require 'cgi'

module Rimu
  class RimuAPI::Orders < Rimu::RimuAPI
      def orders(params={})
          raise ArgumentError, "params should be a hash" unless params.is_a?(Hash)
          default_params = {
              :include_inactive => 'N',
              :server_type => 'VPS',
          }
          filters = prep_data(default_params, params)
          path = "/r/orders;" + filters.collect {|k,v| "#{k}=#{CGI::escape(v.to_s)}"}.join(';')
          send_request(path, "about_orders")
      end

      def order(oid)
          raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
          send_request("/r/orders/order-#{oid}-dn", "about_order")
      end
  end
end
