module BannerSyncinator
  class PersonSynchronizer
    attr_reader :old_person, :new_person, :affiliation

    def initialize(person_change, affiliation)
      @old_person = person_change.old_person
      @new_person = person_change.new_person
      @affiliation = affiliation
      @uuid = old_person.uuid
    end

    def call
      change_person!

      {banner: :banner_id, biola_id: :biola_id}.each do |type, att|
        change_id! type, att
      end

      change_address!

      {university: :university_email, personal: :personal_email}.each do |type, att|
        if both_respond_to? att
          change_email! type, att
        end
      end

      # TODO: this should be alt office phone instead of home phone
      {office: :office_phone, home: :home_phone}.each do |type, att|
        if both_respond_to? att
          change_phone! type, att
        end
      end
    end

    private

    PERSON_ATTRS = [
      :last_name, :first_name, :middle_name, :preferred_name,
      :gender, :partial_ssn, :birth_date, :privacy,
      :pay_type, :full_time, :employee_type, :department, :title, :job_type
    ]

    ADDRESS_ATTRS = [:street_1, :street_2, :city, :state, :zip, :country]

    attr_reader :uuid

    def change_person!
      if new? PERSON_ATTRS
        hash = person_api :create, person_attributes

        @uuid = hash[:uuid]
      elsif removed? PERSON_ATTRS
        affiliations = old_person.affiliations.map(&:to_s) - [affiliation.to_s]
        person_api :update, affiliations: affiliations
      elsif changed? PERSON_ATTRS
        person_api :update, person_attributes
      end
    end

    def change_id!(type, attribute)
      id_id = old_person.send("#{attribute}_id")
      identifier = new_person.send(attribute)

      if new? attribute
        id_api :create, type: type, identifier: identifier
      elsif removed? attribute
        id_api :destroy, id_id: id_id
      elsif changed? attribute
        id_api :update, id_id: id_id, identifier: identifier
      end
    end

    def change_address!
      if new? ADDRESS_ATTRS
        address_api :create, new_attrs.slice(*ADDRESS_ATTRS).merge(type: :home)
      elsif removed? ADDRESS_ATTRS
        address_api :destroy, address_id: old_person.address_id
      elsif changed? ADDRESS_ATTRS
        address_api :update, new_attrs.slice(*ADDRESS_ATTRS).merge(address_id: old_person.address_id)
      end
    end

    def change_email!(type, attribute)
      email_id = old_person.send("#{attribute}_id")
      address = new_person.send(attribute)

      if new? attribute
        email_api :create, type: type, address: address, primary: true
      elsif removed? attribute
        email_api :destroy, email_id: email_id
      elsif changed? attribute
        email_api :update, email_id: email_id, address: address
      end
    end

    def change_phone!(type, attribute)
      phone_id = old_person.send("#{attribute}_id")
      number = new_person.send(attribute)

      if new? attribute
        phone_api :create, type: type, number: number, primary: true
      elsif removed? attribute
        phone_api :destroy, phone_id: phone_id
      elsif changed? attribute
        phone_api :update, phone_id: phone_id, number: number
      end
    end

    # person_api, id_api, address_api, email_api and phone_api methods
    %w{People IDs Addresses Emails Phones}.each do |klass|
      define_method("#{klass.singularize.downcase}_api") do |method, attributes|
        attributes.merge!(uuid: uuid) unless klass == 'Person' && method == :create

        response = "Trogdir::APIClient::#{klass}".constantize.new.send(method, attributes).perform
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    def person_attributes
      # We can't know all affiliations at once from the banner views
      # so we just add the current one to the trogdir ones
      affiliations = (Array(old_person.affiliations) + [affiliation]).map(&:to_s).uniq
      new_attrs.slice(*PERSON_ATTRS).merge(affiliations: affiliations)
    end

    def common_attrs
      @common_attrs ||= old_person.attributes.keys & new_person.attributes.keys
    end

    def old_attrs
      @old_attrs ||= old_person.attributes.slice(*common_attrs)
    end

    def new_attrs
      @new_attrs ||= new_person.attributes.slice(*common_attrs)
    end

    def new?(*attributes)
      attributes.flatten!
      old_attrs.slice(*attributes).values.all?(&:blank?) && new_attrs.slice(*attributes).values.any?(&:present?)
    end

    def changed?(*attributes)
      attributes.flatten!
      old_attrs.slice(*attributes) != new_attrs.slice(*attributes)
    end

    def removed?(*attributes)
      attributes.flatten!
      old_attrs.slice(*attributes).values.any?(&:present?) && new_attrs.slice(*attributes).values.all?(&:blank?)
    end

    def both_respond_to?(attribute)
      old_person.respond_to?(attribute) && new_person.respond_to?(attribute)
    end
  end
end