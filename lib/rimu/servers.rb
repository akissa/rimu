class Rimu::Servers < Rimu
    def default_vps_params
        @default_vps_params = {
            :billing_oid => nil,
            :dc_location => nil,
            :file_injection_data => nil,
            :host_server_oid => nil,
            :instantiation_options => {
                :domain_name => nil,
                :password => nil,
                :distro => nil,
                :cloud_config_data => nil,
                :control_panel => nil,
            },
            :instantiation_via_clone_options => {
                :domain_name => nil,
                :vps_order_oid_to_clone => nil,
            },
            :ip_request => {
                :extra_ip_reason => nil,
                :num_ips => nil,
                :requested_ips => nil,
            },
            :is_just_minimal_init => nil,
            :meta_data => nil,
            :pricing_plan_code => nil,
            :user_oid => nil,
            :vps_parameters => {
                :disk_space_mb => nil,
                :memory_mb => nil,
                :disk_space_2_mb => nil,
            },
            :vps_type => nil,
        }
    end

    def create(params)
        raise ArgumentError, "params should be a hash" unless params.is_a?(Hash)
        raise ArgumentError, "params should contain atleast instantiation_options or instantiation_via_clone_options" \
        unless params.has_key?(:instantiation_options) || params.has_key?(:instantiation_via_clone_options)
        data = {:new_order_request => prep_data(default_vps_params, params)}
        send_request("/r/orders/new-vps", "about_order", "POST", data)
    end

    def reinstall(oid, params={})
        raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
        raise ArgumentError, "params should be a hash" unless params.is_a?(Hash)
        data = {:reinstall_request => prep_data(default_vps_params, params)}
        send_request("/r/orders/order-#{oid}-dn/vps/reinstall", "running_vps_info", "PUT", data)
    end

    def status(oid)
        raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
        send_request("/r/orders/order-#{oid}-dn/vps", "running_vps_info")
    end

    def info(oid)
        raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
        send_request("/r/orders/order-#{oid}-dn/vps", "about_order")
    end

    def cancel(oid)
        raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
        send_request("/r/orders/order-#{oid}-dn/vps", "cancel_messages", "DELETE")
    end

    def move(oid, params)
        raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
        raise ArgumentError, "params should be a hash" unless params.is_a?(Hash)
        default_params = {
            :update_dns=>false,
            :move_reason=>'',
            :pricing_change_option=>'CHOOSE_BEST_OPTION',
            :selected_host_server_oid=>nil
        }
        data = {:vps_move_request => prep_data(default_params, params)}
        send_request("/r/orders/order-#{oid}-dn/vps/host-server", "about_order", "PUT", data)
    end

    def resize(oid, params)
        raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
        raise ArgumentError, "params should be a hash" unless params.is_a?(Hash)
        default_params = {
            :disk_space_2_mb => nil,
            :disk_space_mb => nil,
            :memory_mb => nil,
        }
        data = {:vps_resize_request => prep_data(default_params, params)}
        send_request("/r/orders/order-#{oid}-dn/vps/parameters", "resource_change_result", "PUT", data)
    end

    def change_state(oid, new_state)
        raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
        params = {:running_state_change_request=>{:running_state=>new_state}}
        send_request("/r/orders/order-#{oid}-dn/vps/running-state", "running_vps_info", "PUT", params)
    end

    def reboot(oid)
        raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
        change_state(oid, "RESTARTING")
    end

    def shutdown(oid)
        raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
        change_state(oid, "NOTRUNNING")
    end

    def start(oid)
        raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
        change_state(oid, "RUNNING")
    end

    def power_cycle(oid)
        raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
        change_state(oid, "POWERCYCLING")
    end

    def data_transfer(oid)
        raise ArgumentError, "oid should be an Integer" unless oid.is_a?(Integer)
        send_request("/r/orders/order-#{oid}-dn/vps/data-transfer-usage", "data_transfer_usage_info")
    end
end
