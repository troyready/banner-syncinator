module Workers
  class AcceptedStudents < Workers::Base
    affiliation :accepted_student

    recurrence do
      hourly.hour_of_day(*WORK_HOURS).day(*WORKDAYS)
    end
  end
end
