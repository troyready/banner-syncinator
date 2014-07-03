module Workers
  class Alumni < Workers::Base
    affiliation :alumnus

    recurrence do
      weekly
    end
  end
end
