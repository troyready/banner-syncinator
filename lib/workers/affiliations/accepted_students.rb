module Workers
  module Affiliations
    class AcceptedStudents < Base
      affiliation :accepted_student

      recurrence do
        hourly.hour_of_day(*WORK_HOURS).day(*WORKDAYS)
      end
    end
  end
end
