module Banner
  class Student < Banner::Person
    include Banner::NonEmployee

    ATTRS = superclass::ATTRS + [:majors, :minors, :mailbox]

    default_readers({
      mailbox:  :MAILBOX,
    })

    def majors
      Array(raw_attributes[:MAJOR])
    end

    def minors
      Array(raw_attributes[:MINOR])
    end

    SQL_ALL = "SELECT * FROM bsv_trogdir_student"
    SQL_ONE = "SELECT * FROM bsv_trogdir_student WHERE id = :1"
  end
end
