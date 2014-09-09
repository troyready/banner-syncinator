module Workers
  module Affiliations
    class Trustees < Base
      affiliation :trustee

      recurrence do
        daily
      end
    end
  end
end
