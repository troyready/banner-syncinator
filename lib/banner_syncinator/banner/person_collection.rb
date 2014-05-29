module Banner
  class PersonCollection < BannerSyncinator::PersonCollection
    def self.all_for(affiliation)
      affiliation.banner_person.collection
    end
  end
end