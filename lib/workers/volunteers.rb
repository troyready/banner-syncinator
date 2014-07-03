module Workers
  class Volunteers < Workers::Base
    affiliation :volunteer

    recurrence do
      daily
    end
  end
end
