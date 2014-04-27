module Trogdir
  class Person < BannerSyncinator::Person
    ATTRS = superclass::ATTRS + [
      :uuid, :affiliations,
      :banner_id_id, :biola_id_id, :address_id, :university_email_id, :personal_email_id, :office_phone_id, :home_phone_id
    ]

    FIELD_MAPPINGS = {
      uuid:                 :uuid,
      banner_id:            -> (person) { person[:ids].find{|id| id[:type] == 'banner'}.try(:[], :identifier).try :to_i },
      biola_id:             -> (person) { person[:ids].find{|id| id[:type] == 'biola_id'}.try :[], :identifier },
      last_name:            :last_name,
      first_name:           :first_name,
      middle_name:          :middle_name,
      preferred_name:       :preferred_name,
      gender:               -> (person) { person[:gender].to_sym if person[:gender] },
      partial_ssn:          :partial_ssn,
      birth_date:           -> (person) { Date.parse(person[:birth_date]) if person[:birth_date] },
      privacy:              :privacy,
      affiliations:         :affiliations,
      street_1:             -> (person) { person[:addresses].find{|ad| ad[:type] == 'home'}.try :[], :street_1 },
      street_2:             -> (person) { person[:addresses].find{|ad| ad[:type] == 'home'}.try :[], :street_2 },
      city:                 -> (person) { person[:addresses].find{|ad| ad[:type] == 'home'}.try :[], :city },
      state:                -> (person) { person[:addresses].find{|ad| ad[:type] == 'home'}.try :[], :state },
      zip:                  -> (person) { person[:addresses].find{|ad| ad[:type] == 'home'}.try :[], :zip },
      country:              -> (person) { person[:addresses].find{|ad| ad[:type] == 'home'}.try :[], :country },
      university_email:     -> (person) { person[:emails].find{|e| e[:type] == 'university'}.try :[], :address },
      personal_email:       -> (person) { person[:emails].find{|e| e[:type] == 'personal'}.try :[], :address },

      # IDs needed to do updates and destroys against the Trogdir API
      banner_id_id:         -> (person) { person[:ids].find{|id| id[:type] == 'banner'}.try :[], :id },
      biola_id_id:          -> (person) { person[:ids].find{|id| id[:type] == 'biola_id'}.try :[], :id },
      address_id:           -> (person) { person[:addresses].find{|id| id[:type] == 'home'}.try :[], :id },
      university_email_id:  -> (person) { person[:emails].find{|e| e[:type] == 'university'}.try :[], :id },
      personal_email_id:    -> (person) { person[:emails].find{|e| e[:type] == 'personal'}.try :[], :id },
    }

    attr_accessor *ATTRS

    # Convert attributes from Trogdir API to Person attributes
    def self.import(hash_from_trogdir)
      attributes = FIELD_MAPPINGS.each_with_object({}) do |(att, json_att), atts|
        if json_att.respond_to? :call
          atts[att] = json_att.call(hash_from_trogdir)
        else
          atts[att] = hash_from_trogdir[json_att]
        end
      end

      self.new(attributes)
    end

    def self.find(banner_id)
      person_hash = Trogdir::Client.call :by_id, id: banner_id, type: :banner

      # TODO: not sure if this will really be blank on 404
      if person_hash.blank?
        BannerSyncinator::NullPerson.new
      else
        import(person_hash)
      end
    end

    def self.collection
      affiliation = self.to_s.demodulize.underscore

      person_hashes = Trogdir::Client.call :index, affiliation: affiliation
      people = person_hashes.map { |h| Person.import(h) }

      Trogdir::PersonCollection.new people
    end
  end
end