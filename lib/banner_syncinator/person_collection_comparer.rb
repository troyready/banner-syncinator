module BannerSyncinator
  class PersonCollectionComparer
    attr_reader :old_collection, :new_collection

    def initialize(old_collection, new_collection)
      @old_collection = old_collection
      @new_collection = new_collection
    end

    def added
      @added ||= (new_collection - old_collection).map do |new_person|
        old_person = Trogdir::Person.find(new_person.biola_id)

        PersonChange.new(old_person, new_person)
      end
    end

    def updated
      @updated ||= new_collection.people.map { |new_person|
        old_person = old_collection[new_person]

        if old_person && old_person != new_person
          PersonChange.new(old_person, new_person)
        end
      }.compact # remove nils
    end

    def removed
      @removed ||= (old_collection - new_collection).map do |person|
        PersonChange.new(person, NullPerson.new)
      end
    end

    def changed
      @changed ||= added + updated + removed
    end
  end
end