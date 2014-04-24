module Trogdir
  class Person < BannerSyncinator::Person
    ATTRS = superclass::ATTRS + [
      :uuid, :affiliations,
      :banner_id_id, :biola_id_id, :address_id, :university_email_id, :personal_email_id, :office_phone_id, :home_phone_id
    ]

    FIELD_MAPPINGS = {
      uuid:                 :uuid,
      banner_id:            -> (person) { person[:ids].find{|id| id[:type] == 'banner'}.try :[], :identifier },
      biola_id:             -> (person) { person[:ids].find{|id| id[:type] == 'biola_id'}.try :[], :identifier },
      last_name:            :last_name,
      first_name:           :first_name,
      middle_name:          :middle_name,
      preferred_name:       :preferred_name,
      gender:               :gender,
      partial_ssn:          :partial_ssn,
      birth_date:           :birth_date,
      privacy:              :privacy,
      affiliations:         :affiliations,
      street_1:             :street_1,
      street_2:             :street_2,
      city:                 :city,
      state:                :state,
      zip:                  :zip,
      country:              :country,
      university_email:     -> (person) { person[:emails].find{|e| e[:type] == 'university'}.try :[], :address },
      personal_email:       -> (person) { person[:emails].find{|e| e[:type] == 'personal'}.try :[], :address },

      # Employee specific
      pay_type:       :pay_type,
      full_time:      :full_time,
      employee_type:  :employee_type,
      department:     :department,
      title:          :title,
      job_type:       :job_type,
      office_phone:   -> (person) { person[:phones].find{|e| e[:type] == 'office'}.try :[], :number },

      # IDs needed to do updates and destroys against the Trogdir API
      banner_id_id:         -> (person) { person[:ids].find{|id| id[:type] == 'banner'}.try :[], :id },
      biola_id_id:          -> (person) { person[:ids].find{|id| id[:type] == 'biola_id'}.try :[], :id },
      address_id:           -> (person) { person[:addresses].find{|id| id[:type] == 'home'}.try :[], :id },
      university_email_id:  -> (person) { person[:emails].find{|e| e[:type] == 'university'}.try :[], :id },
      personal_email_id:    -> (person) { person[:emails].find{|e| e[:type] == 'personal'}.try :[], :id },
      office_phone_id:      -> (person) { person[:phones].find{|p| p[:type] == 'office'} .try :[], :id }
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
      person_hash = Trogdir::API.call :by_id, id: banner_id, type: :banner

      # TODO: not sure if this will really be blank on 404
      if person_hash.blank?
        BannerSyncinator::NullPerson.new
      else
        import(person_hash)
      end
    end
  end
end