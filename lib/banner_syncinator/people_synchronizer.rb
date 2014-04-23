module BannerSyncinator
  class PeopleSynchronizer
    attr_reader :affiliation

    def initialize(affiliation)
      @affiliation = affiliation
    end

    def sync!
      comparer.changed.each do |person_change|
        PersonSynchronizer.new(person_change, affiliation).call
      end
    end

    private

    def trogdir_people
      @trogdir_people ||= Trogdir::PersonCollection.all_for(affiliation)
    end

    def banner_people
      @banner_people ||= Banner::PersonCollection.all_for(affiliation)
    end

    def comparer
      @comparer ||= PersonCollectionComparer.new(trogdir_people, banner_people)
    end
  end
end