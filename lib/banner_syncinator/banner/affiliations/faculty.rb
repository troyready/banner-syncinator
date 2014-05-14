module Banner
  class Faculty < Banner::Person
    SQL_ALL = "SELECT i.* FROM bsv_lum_faculty_role f, bgv_personal_info i WHERE f.faculty_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"
    SQL_ONE = "SELECT i.* FROM bsv_lum_faculty_role f, bgv_personal_info i WHERE f.faculty_pidm = i.pidm and id = :1"

    ATTRS = superclass::ATTRS + [:partial_ssn, :birth_date]
  end
end