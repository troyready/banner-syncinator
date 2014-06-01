module Banner
  module NonEmployee
    ADDITIONAL_ATTRS = [:partial_ssn, :birth_date, :country, :personal_email]

    def self.included(base)
      base.const_set(:ATTRS, base.superclass::ATTRS + ADDITIONAL_ATTRS)

      base.default_readers({
        partial_ssn:    :SSN,
        country:        :NATION
      })
    end

    def birth_date
      dob = raw_attributes[:DOB]
      Date.strptime(dob, '%m/%d/%Y') unless dob.blank?
    end

    def personal_email
      raw_attributes[:EMAIL_PERS].try :strip
    end
  end
end