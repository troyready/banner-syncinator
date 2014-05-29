module Trogdir
  class PersonCollection < BannerSyncinator::PersonCollection
    def self.all_for(affiliation)
      affiliation.trogdir_person.collection
    end
  end
end