module Availability
  module InstanceMethods
    def openings(start_date, end_date)
      self.listings.select do |listing|
        listing.available(start_date, end_date)
      end
    end
  end

  module ClassMethods
    def most_reservations(field)
      joins(:listings => :reservations).group(field).order("count(*) desc").limit(1).first
    end

    def highest_ratio(field)
      joins(:listings => :reservations).group(field).order("count(listings.id)/count(reservations.id) DESC").limit(1).first
    end
  end
end