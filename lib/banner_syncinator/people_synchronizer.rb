module BannerSyncinator
  class PeopleSynchronizer
    attr_reader :affiliation

    def initialize(affiliation)
      @affiliation = Affiliation.find(affiliation)
    end

    def sync!
      comparer.changed.each do |person_change|
        PersonSynchronizer.new(person_change, affiliation).call
      end
    end

    private

    def trogdir_people
      @trogdir_people ||= affiliation.trogdir_person.collection
    end

    def banner_people
      @banner_people ||= affiliation.banner_person.collection
    end

    def comparer
      @comparer ||= PersonCollectionComparer.new(trogdir_people, banner_people)
    end
  end
end