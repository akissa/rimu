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
end
