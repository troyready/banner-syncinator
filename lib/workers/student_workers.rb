module Workers
  class StudentWorkers < Workers::Base
    affiliation :student_worker

    recurrence do
      hourly.hour_of_day(*WORK_HOURS).day(*WORKDAYS)
    end
  end
end
