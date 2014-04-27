module Banner
  class Trustee < Banner::Person
    SQL = "SELECT i.* FROM bsv_lum_trustee_role t, bgv_personal_info i WHERE t.trustee_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"
  end
end