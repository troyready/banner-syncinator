module Workers
  class Trustees < Workers::Base
    affiliation :trustee

    recurrence do
      daily
    end
  end
end
