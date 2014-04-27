module Banner
  class AcceptedStudent < Banner::Person
    SQL = "SELECT i.* FROM bsv_lum_accepted a, bgv_personal_info i WHERE a.accepted_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"
  end
end