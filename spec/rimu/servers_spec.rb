require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
require 'rimu'

describe Rimu::Servers do
    before :each do
        @api_key = 'foo'
        @rimu = Rimu::Servers.new(:api_key => @api_key)
    end

    it 'should be a Rimu instance' do
        @rimu.class.should < Rimu
    end

    %w(create info cancel move resize reinstall reboot shutdown start power_cycle data_transfer).each do |action|
        it "should allow accessing the Rimu::Servers API #{action} method" do
            @rimu.should respond_to(action.to_sym)
        end
    end
end
