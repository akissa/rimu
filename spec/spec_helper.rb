$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start
if ENV['CI']=='true'
  require 'codecov'
  require 'codeclimate-test-reporter'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
  ENV['CODECLIMATE_REPO_TOKEN'] = "98eb635c4bb4c62c56e531c05c69d911616f3fa319cf79a86ef7b6b783f42fa9"
  CodeClimate::TestReporter.start
end

require 'mocha/api'
require 'rimu'

RSpec.configure do |config|
    config.mock_with :mocha
    config.expect_with :rspec do |c|
        c.syntax = :should
    end
end
