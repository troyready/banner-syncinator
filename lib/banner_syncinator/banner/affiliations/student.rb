module Banner
  class Student < Banner::Person
    SQL_ALL = "SELECT i.* FROM bsv_lum_student_role s, bgv_personal_info i WHERE s.student_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"
    SQL_ONE = "SELECT i.* FROM bsv_lum_student_role s, bgv_personal_info i WHERE s.student_pidm = i.pidm AND id = :1"
  end
end