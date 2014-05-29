module BannerSyncinator

  def self.initialize!
    require 'rails_config'
    require 'sidekiq'
    require 'oj'
    require 'mail'
    require 'active_support/core_ext'
    require 'trogdir_api_client'

    env = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || :development

    RailsConfig.load_and_set_settings('./config/settings.yml', "./config/settings.#{env}.yml", './config/settings.local.yml')

    MultiJson.use :oj

    ActiveSupport::Inflector.inflections do |inflect|
     inflect.irregular 'alumnus', 'alumnus'
    end

    Mail.defaults do
      delivery_method Settings.email.delivery_method, Settings.email.options.to_hash
    end

    Sidekiq.configure_server do |config|
      config.redis = { url: Settings.redis.url, namespace: 'banner-syncinator' }
    end

    Sidekiq.configure_client do |config|
      config.redis = { url: Settings.redis.url, namespace: 'banner-syncinator' }
    end

    if defined? ::ExceptionNotifier
      require 'exception_notification/sidekiq'
      ExceptionNotifier.register_exception_notifier(:email, Settings.exception_notification.options.to_hash)
    end

    TrogdirAPIClient.configure do |config|
      config.scheme = Settings.trogdir.scheme
      config.host = Settings.trogdir.host
      config.script_name = Settings.trogdir.script_name
      config.version = Settings.trogdir.version
      config.access_id = Settings.trogdir.access_id
      config.secret_key = Settings.trogdir.secret_key
    end

    require './lib/banner_syncinator/null_person'
    require './lib/banner_syncinator/person'
    require './lib/banner_syncinator/person_change'
    require './lib/banner_syncinator/person_collection'
    require './lib/banner_syncinator/person_collection_comparer'
    require './lib/banner_syncinator/person_synchronizer'
    require './lib/banner_syncinator/people_synchronizer'
    require './lib/banner_syncinator/worker'
    require './lib/banner_syncinator/banner'
    require './lib/banner_syncinator/trogdir'
    require './lib/banner_syncinator/affiliation'

    true
  end
end
