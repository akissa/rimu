require 'json'
require 'ostruct'
require 'httparty'

require "rimu/version"

class Rimu
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

    def set_headers
        {
            'Content-Type' =>'application/json',
            'Accept' =>'application/json',
            'User-Agent' => 'RimuAPI-Ruby',
            'Authorization' => 'rimuhosting apikey=' % @api_key
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

    def error?(response)
        response and response["extended_error_infos"] and ! response["extended_error_infos"].empty?
    end

    def error_message(response)
        response["extended_error_infos"].collect { |err|
            "  - Error #{err["human_readable_message"]}.  "
        }.join("\n")
    end

    def format_response(response)
        if response.has_key?("pricing_plan_infos")
            result = response["pricing_plan_infos"]
        elsif response.has_key?("about_orders")
            result = response["about_orders"]
        elsif response.has_key?("distro_infos")
            result = response["distro_infos"]
        elsif response.has_key?("billing_methods")
            result = response["billing_methods"]
        else
            result = []
        end
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
end
