module Banner
  class StudentWorker < Employee
    SQL_ALL = "SELECT * FROM bpv_current_employees WHERE student_worker = 'Y'"
    SQL_ONE = "SELECT * FROM bpv_current_employees WHERE student_worker = 'Y' AND id = :1"
  end
end
