module Workers
  module Affiliations
    class Employees < Base
      affiliation :employee

      recurrence do
        hourly.hour_of_day(*WORK_HOURS).day(*WORKDAYS)
      end
    end
  end
end
