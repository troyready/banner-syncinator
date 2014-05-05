module Banner
  class Person < BannerSyncinator::Person
    default_readers({
      banner_id:        :PIDM,
      biola_id:         :ID,
      last_name:        :LNAME,
      first_name:       :FNAME,
      middle_name:      :MNAME,
      preferred_name:   :PNAME,
      partial_ssn:      :SSN,
      street_1:         :STREET1,
      street_2:         :STREET2,
      city:             :CITY,
      state:            :STATE,
      zip:              :ZIP,
      country:          :NATION,
      university_email: :EMAIL,
      personal_email:   :EMAIL_PER
    })

    def gender
      case raw_attributes['GENDER']
      when 'M'
        :male
      when 'F'
        :female
      end
    end

    def birth_date
      dob = raw_attributes['DOB']
      Date.strptime(dob, '%m/%d/%Y') unless dob.blank?
    end

    def privacy
      raw_attributes['CONFID'] == 'Y'
    end

    def self.find(biola_id)
      sql = self::SQL_ONE
      params = {1 => biola_id.to_s.rjust(8, '0')}

      person = nil
      DB.exec(sql, *params.values) do |row|
        person = new(row)
      end

      person || BannerSyncinator::NullPerson.new
    end

    def self.collection
      sql = self::SQL_ALL

      Banner::PersonCollection.new.tap do |collection|
        DB.exec(sql) do |row|
          collection << Person.new(row)
        end
      end
    end
  end
end