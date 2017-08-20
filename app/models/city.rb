class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  include Availability::InstanceMethods
  extend Availability::ClassMethods

  def city_openings(start_date, end_date)
    openings(start_date, end_date)
  end

  def self.most_res
    most_reservations("cities.id")
  end

  def self.highest_ratio_res_to_listings
    highest_ratio("cities.id")
  end
end

