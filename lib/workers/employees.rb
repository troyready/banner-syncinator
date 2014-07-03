module Workers
  class Employees < Workers::Base
    affiliation :employee

    recurrence do
      hourly.hour_of_day(*WORK_HOURS).day(*WORKDAYS)
    end
  end
end
