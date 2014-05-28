module Banner
  class Volunteer < Employee
    SQL_ALL = "SELECT * FROM bpv_current_employees WHERE ecls = 52 AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"
    SQL_ONE = "SELECT * FROM bpv_current_employees WHERE ecls = 52 id = :1"
  end
end