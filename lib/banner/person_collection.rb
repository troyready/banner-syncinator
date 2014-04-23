module Banner
  class PersonCollection < BannerSyncinator::PersonCollection
    def self.all_for(affiliation)
      klass = "Banner::Affiliation::#{affiliation.to_s.classify}".constantize
      klass.collection
    end
  end
end