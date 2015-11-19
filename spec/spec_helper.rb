$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'

SimpleCov.start
if ENV['CI']=='true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'mocha/api'
require 'rimu'

RSpec.configure do |config|
    config.mock_with :mocha
    config.expect_with :rspec do |c|
        c.syntax = :should
    end
end
