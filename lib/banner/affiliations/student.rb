module Banner
  class Student < Banner::Person
    include Banner::NonEmployee

    SQL_ALL = "SELECT i.* FROM bsv_lum_student_role s, bgv_personal_info i WHERE s.student_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"
    SQL_ONE = "SELECT i.* FROM bsv_lum_student_role s, bgv_personal_info i WHERE s.student_pidm = i.pidm AND id = :1"

    SQL_ALL = "SELECT * FROM bsv_trogdir_student"
    SQL_ONE = "SELECT * FROM bsv_trogdir_student WHERE id = :1"
  end
end
