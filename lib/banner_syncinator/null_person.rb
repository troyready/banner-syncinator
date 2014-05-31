module BannerSyncinator
  class NullPerson
    def present?() false end
    def blank?() true end
    def to_ary() [] end
    def to_s() '' end

    def initialize(mimick = Person)
      mimick = mimick.class unless mimick.class == Class
      @mimick = mimick
    end

    def attributes
      Hash[mimick::ATTRS.map { |att| [att, nil] }]
    end

    def is?(other)
      other.class == self.class
    end
    alias :eql? :is?
    alias :== :is?

    def hash
      0.hash
    end

    def respond_to?(method)
      attributes.has_key?(method.to_sym) || super
    end

    def method_missing(*args, &block)
      nil
    end

    private

    attr_reader :mimick
  end
end