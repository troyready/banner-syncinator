module Workers
  module Affiliations
    class Alumni < Base
      affiliation :alumnus

      recurrence do
        weekly.day(:friday)
      end
    end
  end
end
