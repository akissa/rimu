$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'

if ENV['CI']=='true'
  require 'codecov'
  SimpleCov.formatters = [
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::Codecov,
  ]
end
SimpleCov.start

require 'mocha/api'
require 'rimu'

RSpec.configure do |config|
    config.mock_with :mocha
    config.expect_with :rspec do |c|
        c.syntax = :should
    end
end
