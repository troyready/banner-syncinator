module Banner
  class Alumnus < Banner::Person
    SQL_ALL = "SELECT i.* FROM bsv_lum_alumni_role a, bgv_personal_info i WHERE a.alumni_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"
    SQL_ONE = "SELECT i.* FROM bsv_lum_alumni_role a, bgv_personal_info i where a.alumni_pidm = i.pidm AND id = :1"

    ATTRS = superclass::ATTRS + [:partial_ssn, :birth_date, :country, :personal_email]
  end
end