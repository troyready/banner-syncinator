module Workers
  class Faculty < Workers::Base
    affiliation :faculty

    recurrence do
      hourly.hour_of_day(*WORK_HOURS).day(*WORKDAYS)
    end
  end
end
