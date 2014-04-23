module BannerSyncinator
  class PersonCollection
    include Enumerable

    attr_accessor :people

    def initialize(people = [])
      @people = Array(people)
    end

    def <<(person)
      @people << person
    end

    def [](person)
      people.find do |c|
        c.is? person
      end
    end

    def each
      people.each do |person|
        yield person
      end
    end

    def includes?(person)
      !!self[person]
    end

    def -(other_collection)
      unless other_collection.is_a? PersonCollection
        raise ArgumentError, "other_collection must be a #{self.class}"
      end

      people - other_collection.people
    end
  end
end