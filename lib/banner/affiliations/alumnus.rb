module Banner
  class Alumnus < Banner::Person
    SQL = "SELECT i.* FROM bsv_lum_alumni_role a, bgv_personal_info i WHERE a.alumni_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"
  end
end