require 'sidekiq'
require 'sidekiq/exception_handler' # remove in sidetiq > 0.5.0
require 'sidetiq'

module BannerSyncinator
  class Worker
    include Sidekiq::Worker
    include Sidetiq::Schedulable

    recurrence do
      # TODO: schedule more often
      daily.hour_of_day(Settings.schedule.hour)
    end

    def initialize
      # TODO: set affiliation
      @synchronizer = PeopleSynchronizer.new
    end

    def perform
      @synchronizer.sync!
    end
  end
end