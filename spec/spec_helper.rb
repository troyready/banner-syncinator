$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

ENV['RACK_ENV'] = ENV['RAILS_ENV'] = 'test'

require 'bundler'
Bundler.setup :default, :test

require 'rspec'
# require 'webmock/rspec'
# require 'factory_girl'
# require 'faker'
# require 'trogdir_api'
require 'pry'

require 'banner_syncinator'
BannerSyncinator.initialize!

# TrogdirAPI.initialize!

# TrogdirModels.load_factories
# FactoryGirl.find_definitions

Dir['./spec/support/*.rb'].each { |f| require f }

RSpec.configure do |config|
  # config.include FactoryGirl::Syntax::Methods

  # config.before do
  #   stub_request(:any, /.*/).to_rack Trogdir::API
  # end

  # Clean/Reset Mongoid DB prior to running each test.
  # config.before(:each) do
  #   Mongoid::Sessions.default.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  # end
end