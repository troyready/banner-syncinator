module Workers
  module Affiliations
    class Alumni < Base
      affiliation :alumnus

      recurrence do
        weekly.day_of_week 5
      end
    end
  end
end
