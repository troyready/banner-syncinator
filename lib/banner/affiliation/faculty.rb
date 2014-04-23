module Banner
  module Affiliation
    class Faculty < Base
      SQL = "SELECT i.* FROM bsv_lum_faculty_role f, bgv_personal_info i WHERE f.faculty_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"
    end
  end
end