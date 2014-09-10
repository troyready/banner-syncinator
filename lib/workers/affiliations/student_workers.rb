module Workers
  module Affiliations
    class StudentWorkers < Base
      affiliation :student_worker

      recurrence do
        hourly.hour_of_day(*WORK_HOURS).day(*WORKDAYS)
      end
    end
  end
end
