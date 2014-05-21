module BannerSyncinator
  class NullPerson
    def present?() false end
    def blank?() true end
    def to_ary() [] end
    def to_s() '' end

    def attributes
      Hash[Person::ATTRS.map { |att| [att, nil] }]
    end

    def is?(other)
      other.class == self.class
    end
    alias :eql? :is?
    alias :== :is?

    def hash
      0.hash
    end

    def method_missing(*args, &block)
      nil
    end
  end
end