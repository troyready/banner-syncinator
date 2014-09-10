require 'sidekiq'
require 'sidekiq/exception_handler' # remove in sidetiq > 0.5.0
require 'sidetiq'

module Workers
  module Affiliations
    class Base
      include Sidekiq::Worker
      include Sidetiq::Schedulable

      WORKDAYS = [:monday, :tuesday, :wednesday, :thursday, :friday]
      WORK_HOURS = (8..17).to_a

      def initialize
        if self.class == Workers::Affiliations::Base
          raise NotImplementedError, 'Worker::Base must be overridden'
        end
      end

      def perform
        if affiliation.nil?
          raise NotImplementedError, 'affiliation must be set'
        end

        PeopleSynchronizer.new(affiliation).sync!
      end

      protected

      def self.affiliation(affiliation)
        @affiliation = affiliation
      end

      def affiliation
        self.class.instance_variable_get(:@affiliation)
      end
    end
  end
end
