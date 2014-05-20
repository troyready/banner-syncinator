module Banner
  module NonEmployee
    ADDITIONAL_ATTRS = [:partial_ssn, :birth_date, :country, :personal_email]

    def self.included(base)
      base.const_set(:ATTRS, base.superclass::ATTRS + ADDITIONAL_ATTRS)

      base.default_readers({
        partial_ssn:    :SSN,
        country:        :NATION,
        personal_email: :EMAIL_PERS
      })
    end

    def birth_date
      dob = raw_attributes[:DOB]
      Date.strptime(dob, '%m/%d/%Y') unless dob.blank?
    end
  end
end