require 'cgi'

class Rimu::Orders < Rimu
    def orders(params={})
        default_params = {
            :include_inactive => 'N',
            :server_type => 'VPS',
        }
        filters = prep_data(default_params, params)
        path = "/r/orders;" + filters.collect {|k,v| "#{k}=#{CGI::escape(v.to_s)}"}.join(';')
        send_request(path, "about_orders")
    end

    def order(oid)
        send_request("/r/orders/order-#{oid}-dn", "about_order")
    end
end
