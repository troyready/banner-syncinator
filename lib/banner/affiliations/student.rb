module Banner
  class Student < Banner::Person
    SQL = "SELECT i.* FROM bsv_lum_student_role s, bgv_personal_info i WHERE s.student_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"
  end
end