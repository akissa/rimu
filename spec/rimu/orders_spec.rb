require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
require 'rimu'

describe Rimu::RimuAPI::Orders do
    before :each do
        @api_key = 'foo'
        @rimu = Rimu::RimuAPI::Orders.new(:api_key => @api_key)
    end

    it 'should be a Rimu instance' do
        @rimu.class.should < Rimu::RimuAPI
    end

    %w(orders order).each do |action|
        it "should allow accessing the Rimu::RimuAPI::Orders API #{action} method" do
            @rimu.should respond_to(action.to_sym)
        end
    end

    describe "when accessing the Rimu::RimuAPI::Orders API orders method" do
        it 'should allow a params hash' do
            @rimu.stubs(:send_request)
            lambda { @rimu.send(:orders, {}) }.should_not raise_error
        end
        it 'should allow a only params of hash type' do
            @rimu.stubs(:send_request)
            lambda { @rimu.send(:orders, 1) }.should raise_error(ArgumentError)
        end
        it 'should not require arguments' do
            @rimu.stubs(:send_request)
            lambda { @rimu.send(:orders) }.should_not raise_error
        end
        it "should request the correct path" do
            @rimu.expects(:send_request).with {|path, _, _, _| path == "/r/orders;include_inactive=N;server_type=VPS" }
            @rimu.send(:orders)
        end
        it "should request the correct path when filters are set" do
            @rimu.expects(:send_request).with {|path, _, _, _| path == "/r/orders;include_inactive=Y;server_type=ALL" }
            @rimu.send(:orders, {:include_inactive=>'Y', :server_type=>'ALL'})
        end
        it "should request the correct path when incorrect filters are set" do
            @rimu.expects(:send_request).with {|path, _, _, _| path == "/r/orders;include_inactive=N;server_type=VPS" }
            @rimu.send(:orders, {:xnclude_inactive=>'Y', :zerver_type=>'ALL'})
        end
        it "should request the correct field" do
            @rimu.expects(:send_request).with {|_, field, _, _| field == "about_orders" }
            @rimu.send(:orders)
        end
        it "should not have the method parameter set" do
            @rimu.expects(:send_request).with {|_, _, method, _| method.nil? && true }
            @rimu.send(:orders)
        end
        it "should not have the data parameter set" do
            @rimu.expects(:send_request).with {|_, _, _, data| data.nil? && true }
            @rimu.send(:orders)
        end
    end

    describe "when accessing the Rimu::RimuAPI::Orders API order method" do
        it 'should take only one argument' do
            @rimu.stubs(:send_request)
            lambda { @rimu.send(:order, 1, {}) }.should raise_error(ArgumentError)
        end
        it 'should require an argument' do
            @rimu.stubs(:send_request)
            lambda { @rimu.send(:order) }.should raise_error(ArgumentError)
        end
        it 'should require argument of Integer type' do
            @rimu.stubs(:send_request)
            lambda { @rimu.send(:order, {}) }.should raise_error(ArgumentError)
        end
        it "should request the correct path" do
            @rimu.expects(:send_request).with {|path, _, _, _| path == "/r/orders/order-10-dn" }
            @rimu.send(:order, 10)
        end
        it "should request the correct field" do
            @rimu.expects(:send_request).with {|_, field, _, _| field == "about_order" }
            @rimu.send(:order, 10)
        end
        it "should not have the method parameter set" do
            @rimu.expects(:send_request).with {|_, _, method, _| method.nil? && true }
            @rimu.send(:order, 10)
        end
        it "should not have the data parameter set" do
            @rimu.expects(:send_request).with {|_, _, _, data| data.nil? && true }
            @rimu.send(:order, 10)
        end
    end
end
