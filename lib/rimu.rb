require 'json'
require 'ostruct'
require 'httparty'

class Rimu
    attr_accessor :logger

    def initialize(args)
        @api_url = args[:api_url] if args[:api_url]
        @logger = args[:logger]
        if args.include?(:api_key)
            @api_key = args[:api_key]
        else
            raise ArgumentError, "The :api_key is required."
        end
    end

    def api_url
        @api_url || "https://api.rimuhosting.com"
    end

    def api_key
        @api_key
    end

    def set_headers
        {
            'Content-Type' =>'application/json',
            'Accept' =>'application/json',
            'User-Agent' => 'RimuAPI-Ruby',
            'Authorization' => 'rimuhosting apikey=%s' % @api_key
        }
    end

    def post(path, data)
        logger.info "POST #{api_url.to_s}#{path} body:#{data.inspect}" if logger
        @options = {headers: set_headers, body: data}
        HTTParty.post(api_url + path, @options).parsed_response
    end

    def get(path)
        logger.info "GET #{api_url.to_s}#{path}" if logger
        @options = {headers: set_headers}
        HTTParty.get(api_url + path, @options).parsed_response
    end

    def delete(path)
        logger.info "DELETE #{api_url.to_s}#{path}" if logger
        @options = {headers: set_headers}
        HTTParty.delete(api_url + path, @options).parsed_response
    end

    def error?(response)
        response and response["jaxrs_response"] and \
        response["jaxrs_response"]["response_type"] and \
        response["jaxrs_response"]["response_type"] == "ERROR"
    end

    def error_message(response)
        "  - Error: #{response["jaxrs_response"]["human_readable_message"]}"
    end

    def format_response(response, field)
        result = response[response.keys[0]]
        result = result[field]
        return result.collect {|item| convert_item(item) } if result.class == Array
        return result unless result.respond_to?(:keys)
        convert_item(result)
    end

    def convert_item(response)
        response.keys.each do |key|
            response[key.downcase] = response[key]
            response.delete(key) if key != key.downcase
        end
        OpenStruct.new(response)
    end

    def send_request(path, field, method="GET", data=false)
        if method == "POST"
            response = post(path, data)
        elsif method == "PUT"
            response = put(path, data)
        elsif method == "DELETE"
            response = delete(path)
        else
            response = get(path)
        end
        raise "Errors completing request [#{path}] @ [#{api_url}] with data [#{data.inspect}]:\n#{error_message(response)}" if error?(response)
        format_response(response, field)
    end

    def distributions
        send_request("/r/distributions", "distro_infos")
    end

    def billing_methods
        send_request("/r/billing-methods", "billing_methods")
    end

    # def pricing_plans
    #     send_request("/r/pricing-plans", "billing_methods")
    # end

    def self.has_namespace(*namespaces)
        namespaces.each do |namespace|
            define_method(namespace.to_sym) do ||
                lookup = instance_variable_get("@#{namespace}")
                return lookup if lookup
                subclass = self.class.const_get(namespace.to_s.capitalize).new(:api_key => api_key, :api_url => api_url)
                instance_variable_set("@#{namespace}", subclass)
                subclass
            end
        end
    end

    has_namespace :orders, :servers
end
Dir[File.expand_path(File.dirname(__FILE__) + '/rimu/*.rb')].each {|f| require f }
