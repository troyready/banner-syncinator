module Workers
  module Affiliations
    class Alumni < Base
      affiliation :alumnus

      recurrence do
        weekly
      end
    end
  end
end
