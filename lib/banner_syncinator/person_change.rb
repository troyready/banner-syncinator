module BannerSyncinator
  class PersonChange
    attr_reader :old_person, :new_person
    def initialize(old_person, new_person)
      @old_person = old_person
      @new_person = new_person
    end
  end
end