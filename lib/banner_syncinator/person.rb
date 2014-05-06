module BannerSyncinator
  class Person
    # TODO: we may be able to ignore university_email since it should be handled by something other than Banner
    ATTRS = [
      :banner_id, :biola_id,
      :last_name, :first_name, :middle_name, :preferred_name,
      :gender, :partial_ssn, :birth_date, :privacy,
      :street_1, :street_2, :city, :state, :zip, :country,
      :university_email, :personal_email
    ]

    ATTRS.each do |attr|
      define_method(attr) do
        raw_attributes[attr]
      end
    end

    def initialize(raw_attributes)
      @raw_attributes = raw_attributes
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
      return false unless other.is_a? Person

      # attributes that are common between the two
      attrs = self.class::ATTRS & other.class::ATTRS

      attrs.all? { |att| other.send(att) == send(att) }
    end

    def to_s
      "#{first_name} #{last_name}"
    end

    protected

    attr_reader :raw_attributes

    def self.default_readers(attribute_mappings)
      attribute_mappings.each do |common_attr, raw_attr|
        define_method(common_attr) do
          raw_attributes[raw_attr]
        end
      end
    end
  end
end