module Banner
  module Affiliation
    class Base
      FIELD_MAPPINGS = {
        banner_id:        :PIDM,
        biola_id:         :ID,
        last_name:        :LNAME,
        first_name:       :FNAME,
        middle_name:      :MNAME,
        preferred_name:   :PNAME,
        gender:           -> (row) { {'M' => :male, 'F' => :female}[row['GENDER']] },
        partial_ssn:      :SSN,
        birth_date:       -> (row) { Date.strptime(row['DOB'], '%m/%d/%Y') unless row['DOB'].blank? },
        privacy:          :CONFID,
        street_1:         :STREET1,
        street_2:         :STREET2,
        city:             :CITY,
        state:            :STATE,
        zip:              :ZIP,
        country:          :NATION,
        university_email: :EMAIL,
        personal_email:   :EMAIL_PER
      }

      def self.collection
        sql = self::SQL
        field_mappings = self::FIELD_MAPPINGS

        Banner::PersonCollection.new.tap do |collection|
          cursor = Banner::DB.connection.exec(sql)
          while row = cursor.fetch_hash
            attributes = field_mappings.each_with_object({}) do |(att, column), atts|
              if column.respond_to? :call
                atts[att] = column.call(row)
              else
                atts[att] = row[column.to_s]
              end
            end

            collection << Person.new(attributes)
          end
        end
      end
    end
  end
end