class Rimu::Orders < Rimu
    def orders
        send_request("/r/orders", "about_orders")
    end

    def order(oid, domain)
        send_request("/r/orders/order-#{oid}-#{domain}", "about_order")
    end
end
