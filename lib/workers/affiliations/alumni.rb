module Workers
  module Affiliations
    class Alumni < Base
      affiliation :alumnus

      recurrence do
        weekly.day(:monday)
      end
    end
  end
end
