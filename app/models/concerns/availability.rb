module Availability
  module InstanceMethods
    def openings(start_date, end_date)
      self.listings.select do |listing|
        listing.available(start_date, end_date)
      end
    end
  end

  module ClassMethods
    def highest_ratio_res_to_listings
      
    end
  end
end