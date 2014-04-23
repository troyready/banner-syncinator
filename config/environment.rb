require 'bundler'
Bundler.setup :default, ENV['RACK_ENV'] || ENV['RAILS_ENV'] || :development

require './lib/banner_syncinator'
BannerSyncinator.initialize!