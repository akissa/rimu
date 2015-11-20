require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
require 'rimu'

describe Rimu::Orders do
    before :each do
        @api_key = 'foo'
        @rimu = Rimu::Orders.new(:api_key => @api_key)
    end

    it 'should be a Rimu instance' do
        @rimu.class.should < Rimu
    end

    %w(orders order).each do |action|
        it "should allow accessing the Rimu::Orders API #{action} method" do
            @rimu.should respond_to(action.to_sym)
        end
    end

    describe "when accessing the Rimu::Orders API orders method" do
        it 'should allow a params hash' do
            @rimu.stubs(:send_request)
            lambda { @rimu.send(:orders, {}) }.should_not raise_error
        end
        it 'should not require arguments' do
            @rimu.stubs(:send_request)
            lambda { @rimu.send(:orders) }.should_not raise_error
        end
        it "should request the correct path" do
            @rimu.expects(:send_request).with {|path, field, method, data| path == "/r/orders;include_inactive=N;server_type=VPS" }
            @rimu.send(:orders)
        end
        it "should request the correct path when filters are set" do
            @rimu.expects(:send_request).with {|path, field, method, data| path == "/r/orders;include_inactive=Y;server_type=ALL" }
            @rimu.send(:orders, {:include_inactive=>'Y', :server_type=>'ALL'})
        end
        it "should request the correct path when incorrect filters are set" do
            @rimu.expects(:send_request).with {|path, field, method, data| path == "/r/orders;include_inactive=N;server_type=VPS" }
            @rimu.send(:orders, {:xnclude_inactive=>'Y', :zerver_type=>'ALL'})
        end
        it "should request the correct field" do
            @rimu.expects(:send_request).with {|path, field, method, data| field == "about_orders" }
            @rimu.send(:orders)
        end
        it "should not have the method parameter set" do
            @rimu.expects(:send_request).with {|path, field, method, data| method.nil? && true }
            @rimu.send(:orders)
        end
        it "should not have the data parameter set" do
            @rimu.expects(:send_request).with {|path, field, method, data| data.nil? && true }
            @rimu.send(:orders)
        end
    end

    describe "when accessing the Rimu::Orders API order method" do
        it 'should take only one argument' do
            @rimu.stubs(:send_request)
            lambda { @rimu.send(:order, 1, {}) }.should raise_error(ArgumentError)
        end
        it 'should require one arguments' do
            @rimu.stubs(:send_request)
            lambda { @rimu.send(:order) }.should raise_error(ArgumentError)
        end
        it "should request the correct path" do
            @rimu.expects(:send_request).with {|path, field, method, data| path == "/r/orders/order-10-dn" }
            @rimu.send(:order, 10)
        end
        it "should request the correct field" do
            @rimu.expects(:send_request).with {|path, field, method, data| field == "about_order" }
            @rimu.send(:order, 10)
        end
        it "should not have the method parameter set" do
            @rimu.expects(:send_request).with {|path, field, method, data| method.nil? && true }
            @rimu.send(:order, 10)
        end
        it "should not have the data parameter set" do
            @rimu.expects(:send_request).with {|path, field, method, data| data.nil? && true }
            @rimu.send(:order, 10)
        end
    end
end
