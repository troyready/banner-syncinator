module BannerSyncinator
  class Person
    # TODO: we may be able to ignore university_email since it should be handled by something other than Banner
    ATTRS = [
      :banner_id, :biola_id,
      :last_name, :first_name, :middle_name, :preferred_name,
      :gender, :partial_ssn, :birth_date, :privacy,
      :street_1, :street_2, :city, :state, :zip, :country,
      :university_email, :personal_email,
      :pay_type, :full_time, :employee_type, :department, :title, :job_type, :office_phone, :home_phone
    ]

    attr_accessor *ATTRS

    def initialize(attrs)
      self.class::ATTRS.each do |att|
        send "#{att}=", attrs[att]
      end
    end

    def self.import
      raise NotImplemented, '#import should be overridden is sub classes'
    end

    def attributes
      self.class::ATTRS.each_with_object({}) { |att, hash| hash[att] = send(att) }
    end

    # I'm preferring is? over eql? because I feel it better represents what we're checking.
    # Which is that they have the same banner_id not that they are the same object or even
    # have the same attributes. But we're also using it for eql? for simple array comparisons.
    def is?(other)
      return false unless other.respond_to? :banner_id

      other.banner_id.to_i == banner_id.to_i
    end
    alias :eql? :is?

    def hash
      banner_id.to_i.hash
    end

    def ==(other)
      return false unless other.is_a? self.class

      self.class::ATTRS.all? { |att| other.send(att) == send(att) }
    end

    def to_s
      "#{first_name} #{last_name}"
    end
  end
end