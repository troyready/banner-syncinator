module Trogdir
  class Person < BannerSyncinator::Person
    ATTRS = superclass::ATTRS + [
      :uuid, :affiliations,

      # Things everyone has in Trogdir but not Banner
      :partial_ssn, :birth_date, :country, :personal_email,

      # IDs needed to do updates and destroys against the Trogdir API
      :banner_id_id, :biola_id_id, :address_id, :university_email_id, :personal_email_id
    ]

    default_readers({
      uuid:                 :uuid,
      last_name:            :last_name,
      first_name:           :first_name,
      middle_name:          :middle_name,
      preferred_name:       :preferred_name,
      partial_ssn:          :partial_ssn,
      affiliations:         :affiliations
    })

    def banner_id
      find(:ids, :banner)[:identifier].try :to_i
    end

    def biola_id
      find(:ids, :biola_id)[:identifier].try :to_i
    end

    def gender
      raw_attributes[:gender].to_sym if raw_attributes[:gender]
    end

    def birth_date
      dob = raw_attributes[:birth_date]
      Date.strptime(dob, '%Y-%m-%d') unless dob.blank?
    end

    def privacy
      raw_attributes[:privacy] == true
    end

    [:street_1, :street_2, :city, :state, :zip, :country].each do |att|
      define_method(att) do
        home_address[att]
      end
    end

    def university_email
      find(:emails, :university)[:address]
    end

    def personal_email
      find(:emails, :personal)[:address]
    end

    def banner_id_id
      find(:ids, :banner)[:id]
    end

    def biola_id_id
      find(:ids, :biola_id)[:id]
    end

    def address_id
      home_address[:id]
    end

    def university_email_id
      find(:emails, :university)[:id]
    end

    def personal_email_id
      find(:emails, :personal)[:id]
    end

    def self.find(biola_id)
      person_hash = Trogdir::Client.call :by_id, id: biola_id, type: :biola_id

      if person_hash.blank?
        BannerSyncinator::NullPerson.new
      else
        new(person_hash)
      end
    end

    def self.collection
      affiliation = self.to_s.demodulize.underscore

      person_hashes = Trogdir::Client.call :index, affiliation: affiliation
      people = person_hashes.map { |h| new(h) }

      BannerSyncinator::PersonCollection.new people
    end

    private

    def find(things, type)
      Array(raw_attributes[things]).find do |thing|
        thing[:type] == type.to_s
      end || {}
    end

    def home_address
      @home_address ||= find(:addresses, :home)
    end
  end
end