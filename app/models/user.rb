class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'

  def guests
    Reservation.joins(:listing).where(listings: {host_id: self}).map {|r| r.guest}
  end

  def hosts
    Listing.joins(:reservations).where(reservations: {guest_id: self}).uniq.map {|l| l.host}
  end

  def host_reviews
    Review.joins(reservation: :listing).where(listings: {host_id: self})
  end
end
