require 'simplecov'
SimpleCov.start

require_relative '../lib/person_file_parser'
require 'rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.order = "random"
end