module BannerSyncinator
  class Affiliation
    attr_reader :slug
    attr_reader :name

    def initialize(slug, name)
      @slug = slug.to_sym
      @name = name.to_s
    end

    def banner_person
      "Banner::#{class_name}".constantize
    end

    def trogdir_person
      "Trogdir::#{class_name}".constantize
    end

    alias :to_s :name

    def self.find(class_or_slug_or_name)
      thing = class_or_slug_or_name

      if thing.is_a? Affiliation
        thing
      elsif thing.respond_to? :affiliation
        thing.affiliation
      else
        klass = BannerSyncinator::Person.descendants.find do |klass|
          begin
            aff = klass.affiliation
            [aff.slug, aff.name].include? thing
          rescue NotImplementedError
          end
        end

        klass.try :affiliation
      end
    end

    private

    def class_name
      slug.to_s.classify
    end
  end
end