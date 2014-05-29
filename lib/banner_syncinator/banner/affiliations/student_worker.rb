module Banner
  class StudentWorker < Employee
    # ecls 30: Student
    # ecls 31: Unknown
    # ecls 33: Student International
    SQL_ALL = "SELECT * FROM bpv_current_employees WHERE ecls IN(30,31,33) AND id NOT LIKE 'X%' AND id NOT LIKE 'Z%'"
    SQL_ONE = "SELECT * FROM bpv_current_employees WHERE ecls IN(30,31,33) id = :1"
  end
end