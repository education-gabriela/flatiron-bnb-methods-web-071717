class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  include Availability::InstanceMethods
  extend Availability::ClassMethods

  def neighborhood_openings(start_date, end_date)
    openings(start_date, end_date)
  end

  def self.most_res
    most_reservations("neighborhoods.id")
  end

  def self.highest_ratio_res_to_listings
    highest_ratio("neighborhoods.id")
  end

end
