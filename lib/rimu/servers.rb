class Rimu::Servers < Rimu
    def create(params)
        send_request("/r/orders/new-vps", "about_order", "POST", params)
    end

    def info(oid)
        send_request("/r/orders/order-#{oid}-dn/vps", "running_vps_info")
    end

    def cancel(oid)
        send_request("/r/orders/order-#{oid}-dn/vps", "cancel_messages", "DELETE")
    end

    def move(oid, params)
        send_request("/r/orders/order-#{oid}-dn/vps/host-server", "about_order", "PUT", params)
    end

    def resize(oid)
        send_request("/r/orders/order-#{oid}-dn/vps/parameters", "resource_change_result", "PUT", params)
    end

    def reinstall(oid)
        send_request("/r/orders/order-#{oid}-dn/vps/reinstall", "running_vps_info", "PUT", params)
    end

    def reboot(oid, params)
        send_request("/r/orders/order-#{oid}-dn/vps/running-state", "running_vps_info", "PUT", params)
    end

    def shutdown(oid, params)
        send_request("/r/orders/order-#{oid}-dn/vps/running-state", "running_vps_info", "PUT", params)
    end

    def start(oid, params)
        send_request("/r/orders/order-#{oid}-dn/vps/running-state", "running_vps_info", "PUT", params)
    end

    def power_cycle(oid, params)
        send_request("/r/orders/order-#{oid}-dn/vps/running-state", "running_vps_info", "PUT", params)
    end

    def data_transfer(oid)
        send_request("/r/orders/order-#{oid}-dn/vps/data-transfer-usage", "data_transfer_usage_info")
    end
end
