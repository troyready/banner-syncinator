module Banner
  class Trustee < Banner::Person
    include Banner::NonEmployee

    SQL_ALL = "SELECT i.* FROM bsv_lum_trustee_role t, bgv_personal_info i WHERE t.trustee_pidm = i.pidm AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"
    SQL_ONE = "SELECT i.* FROM bsv_lum_trustee_role t, bgv_personal_info i WHERE t.trustee_pidm = i.pidm AND id = :1"
  end
end