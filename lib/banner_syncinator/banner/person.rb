module Banner
  class Person < BannerSyncinator::Person
    default_readers({
      banner_id:        :PIDM,
      last_name:        :LNAME,
      first_name:       :FNAME,
      middle_name:      :MNAME,
      preferred_name:   :PNAME,
      street_1:         :STREET1,
      street_2:         :STREET2,
      city:             :CITY,
      state:            :STATE,
      zip:              :ZIP,
      university_email: :EMAIL
    })

    def biola_id
      raw_attributes[:ID].try :to_i
    end

    def gender
      case raw_attributes[:GENDER]
      when 'M'
        :male
      when 'F'
        :female
      end
    end

    def privacy
      raw_attributes[:CONFID] == 'Y'
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
          collection << self.class.new(row)
        end
      end
    end
  end
end