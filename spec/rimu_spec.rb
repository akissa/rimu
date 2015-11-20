require 'spec_helper'

describe Rimu do
    describe 'as a class' do
        it 'should be able to create a new Rimu instance' do
            Rimu.should respond_to(:new)
        end
    end

    describe 'when creating a new Rimu instance' do
        it 'should accept an arguments hash' do
            lambda { Rimu.new(:api_key => 'foo') }.should_not raise_error
        end

        it 'should require an arguments hash' do
            lambda { Rimu.new }.should raise_error(ArgumentError)
        end

        it 'should not fail if an API key is given' do
            lambda { Rimu.new({ :api_key => 'foo' }) }.should_not raise_error
        end

        it 'should fail if no API key is given' do
            lambda { Rimu.new({}) }.should raise_error(ArgumentError)
        end

        it 'should allow providing a logger' do
            api = Rimu.new(:api_key => 'foo', :logger => 'bar')
            api.logger.should == 'bar'
        end

        it 'should return a Rimu instance' do
            Rimu.new(:api_key => 'foo').class.should == Rimu
        end
    end
end

describe 'Rimu' do
    before :each do
        @api_url = 'https://fake-api.rimuhosting.com/'
        @api_key = 'foo'
        @rimu = Rimu.new(:api_key => @api_key, :api_url => @api_url)
    end

    describe 'when initialized with API key' do
        it 'should be able to return the API key provided at creation time' do
            @rimu.api_key.should == 'foo'
        end

        describe 'when returning the current API URL' do
            it 'should return the API URL provided at creation time if one was provided' do
                @rimu = Rimu.new(:api_key => @api_key, :api_url => 'https://fake-api.rimuhosting.com/')
                @rimu.api_url.should == 'https://fake-api.rimuhosting.com/'
            end

            it 'should return the stock Rimu API URL if none was provided at creation time' do
                 @rimu = Rimu.new(:api_key => @api_key)
                 @rimu.api_url.should == 'https://api.rimuhosting.com'
            end
        end
    end

    it 'should be able to submit a request via the API' do
        @rimu.should respond_to(:send_request)
    end

    describe 'when submitting a request via the API' do
        before :each do
            @json = %Q!{}!
            @json.stubs(:parsed_response).returns(JSON.parse(@json))
            HTTParty.stubs(:get).returns(@json)
            HTTParty.stubs(:post).returns(@json)
            HTTParty.stubs(:put).returns(@json)
            HTTParty.stubs(:delete).returns(@json)
            @rimu.stubs(:api_url).returns('https://fake-api.rimuhosting.com/')
        end

        it 'should be able to provide access to the Rimu distributions API' do
            @rimu.should respond_to(:distributions)
        end

        describe 'when providing access to the Rimu distributions API' do
            it 'should allow no arguments' do
                lambda { @rimu.distributions }.should_not raise_error
            end

            it 'should require no arguments' do
                lambda { @rimu.distributions(:foo) }.should raise_error(ArgumentError)
            end
        end

        it 'should be able to provide access to the Rimu Billing Methods API' do
            @rimu.should respond_to(:billing_methods)
        end

        describe 'when providing access to the Rimu Billing Methods API' do
            it 'should allow no arguments' do
                lambda { @rimu.billing_methods }.should_not raise_error
            end

            it 'should require no arguments' do
                lambda { @rimu.billing_methods(:foo) }.should raise_error(ArgumentError)
            end
        end

        # it 'should be able to provide access to the Rimu Pricing Plans API' do
        #     @rimu.should respond_to(:pricing_plans)
        # end
        #
        # describe 'when providing access to the Rimu Pricing Plans API' do
        #     it 'should allow no arguments' do
        #         lambda { @rimu.pricing_plans }.should_not raise_error
        #     end
        #
        #     it 'should require no arguments' do
        #         lambda { @rimu.pricing_plans(:foo) }.should raise_error(ArgumentError)
        #     end
        # end

        it 'should be able to provide access to the Rimu Servers API' do
            @rimu.should respond_to(:servers)
        end

        describe 'when providing access to the Rimu Servers API' do
            it 'should allow no arguments' do
                lambda { @rimu.servers }.should_not raise_error
            end

            it 'should require no arguments' do
                lambda { @rimu.servers(:foo) }.should raise_error(ArgumentError)
            end

            it 'should return a Rimu::Servers instance' do
                @rimu.servers.class.should == Rimu::Servers
            end

            it 'should set the API key on the Rimu::Servers instance to be our API key' do
                @rimu.servers.api_key.should == @api_key
            end

            it 'should set the API url on the Rimu::Servers instance to be our API url' do
                @rimu.servers.api_url.should == @api_url
            end

            it 'should return the same Rimu::Servers instance when called again' do
                rimu = Rimu.new(:api_key => @api_key)
                result = rimu.servers
                rimu.servers.should == result
            end
        end

        it 'should be able to provide access to the Rimu Orders API' do
            @rimu.should respond_to(:orders)
        end

        describe 'when providing access to the Rimu Orders API' do
            it 'should allow no arguments' do
                lambda { @rimu.orders }.should_not raise_error
            end

            it 'should require no arguments' do
                lambda { @rimu.orders(:foo) }.should raise_error(ArgumentError)
            end

            it 'should return a Rimu::Orders instance' do
                @rimu.orders.class.should == Rimu::Orders
            end

            it 'should set the API key on the Rimu::Orders instance to be our API key' do
                @rimu.orders.api_key.should == @api_key
            end

            it 'should set the API url on the Rimu::Orders instance to be our API url' do
                @rimu.orders.api_url.should == @api_url
            end

            it 'should return the same Rimu::Orders instance when called again' do
                rimu = Rimu.new(:api_key => @api_key)
                result = rimu.orders
                rimu.orders.should == result
            end
        end
    end
end
