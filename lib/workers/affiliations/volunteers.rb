module Workers
  module Affiliations
    class Volunteers < Base
      affiliation :volunteer

      recurrence do
        daily
      end
    end
  end
end
