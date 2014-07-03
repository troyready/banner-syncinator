module Workers
  class Students < Workers::Base
    affiliation :student

    recurrence do
      hourly.hour_of_day(*(8..20).to_a).day(*WORKDAYS)
    end
  end
end
