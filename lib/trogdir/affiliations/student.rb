module Trogdir
  class Student < Trogdir::Person
    ATTRS = superclass::ATTRS + [:majors, :minors, :mailbox]

    default_readers({
      mailbox:  :mailbox
    })

    def majors
      Array(raw_attributes[:majors])
    end

    def minors
      Array(raw_attributes[:minors])
    end
  end
end
