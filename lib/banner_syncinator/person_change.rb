module BannerSyncinator
  class PersonChange
    attr_reader :old_person, :new_person

    def initialize(old_person, new_person)
      @old_person = old_person
      @new_person = new_person
    end

    # This method isn't currently used in the code but comes in handy for debugging
    def diff
      {}.tap do |hash|
        diff_attrs.each do |att|
          hash[att] = {old: old_person.send(att), new: new_person.send(att)}
        end
      end
    end

    private

    def common_attrs
      old_person.class::ATTRS & new_person.class::ATTRS
    end

    def diff_attrs
      common_attrs.reject do |att|
        old_person.send(att) == new_person.send(att)
      end
    end
  end
end