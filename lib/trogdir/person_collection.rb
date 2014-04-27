module Trogdir
  class PersonCollection < BannerSyncinator::PersonCollection
    def self.all_for(affiliation)
      klass = "Trogdir::#{affiliation.to_s.classify}".constantize
      klass.collection
    end
  end
end