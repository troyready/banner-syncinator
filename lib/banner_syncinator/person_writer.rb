module BannerSyncinator
  class PersonWriter
    attr_reader :person
    attr_reader :affiliation

    BASE_ATTRS = [
      :last_name, :first_name, :middle_name, :preferred_name,
      :gender, :partial_ssn, :birth_date, :privacy,
      :pay_type, :full_time, :employee_type, :department, :title, :job_type
    ]

    def initialize(person, affiliation)
      @person = person
      @affiliation = affiliation
    end

    def create
      create_person
      create_id :banner, person.banner_id
      create_id :biola_id, person.biola_id
      create_address person.street_1, person.street_2, person.city, person.state, person.zip, person.country
      create_email :personal, person.personal_email
      create_phone :phone, :office, person.office_phone
      create_phone :phone, :home, person.home_phone
    end

    def update(old_person)
      # TODO
    end

    def remove
      update_person person, affiliations: person.affiliations - [affiliation]
    end

    private

    attr_reader :uuid

    # person_api, id_api, address_api, email_api and phone_api methods
    %w{People IDs Addresses Emails Phones}.each do |klass|
      define_method("#{klass.singularize.downcase}_api") do |method, attributes|
        response = "Trogdir::APIClient::#{klass}".constantize.new.send(method, attributes).perform
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    def create_person
      attributes = person.attributes.slice(*BASE_ATTRS).merge(affiliations: [affiliation])
      hash = person_api :create, attributes

      @uuid = hash[:uuid]
    end

    def update_person(attributes)
      person_api :update, attributes.merge(uuid: uuid)
    end

    def create_id(type, identifier)
      if identifier.present?
        id_api :create, uuid: uuid, type: type, identifier: identifier
      end
    end

    def create_address(street_1, street_2, city, state, zip, country)
      if street_1.present?
        address_api(:create,
          uuid: uuid,
          type: :home,
          street_1: street_1,
          street_2: street_2,
          city: city, state: state, zip: zip,
          country: country
        )
      end
    end

    def create_email(type, address, primary = true)
      if address.present?
        email_api :create, uuid: uuid, type: type, address: address, primary: primary
      end
    end

    def create_phone(type, number, primary)
      if number.present?
        phone_api :create, uuid: uuid, type: type, number: number, primary: primary
      end
    end
  end
end