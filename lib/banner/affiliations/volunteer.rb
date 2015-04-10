module Banner
  class Volunteer < Employee
    SQL_ALL = "SELECT * FROM bpv_current_employees WHERE volunteer = 'Y'"
    SQL_ONE = "SELECT * FROM bpv_current_employees WHERE volunteer = 'Y' AND id = :1"
  end
end
