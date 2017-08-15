class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, :checkout, presence: true
  validate :host_different_than_guest, :reservation_date_order, :availability

  def host_different_than_guest
    if self.guest_id == self.listing.host_id
      self.errors.add :guest_id, "host and guest can't be the same"
    end
  end

  def reservation_date_order
    if self.checkin && self.checkout && self.checkin >= self.checkout
      self.errors.add :guest_id, "can't be after checkout date"
    end
  end

  def availability
    reservations = Reservation.where(listing_id: self.listing_id).where.not(id: id)

    reservations.each do |reservation|
      date_interval = reservation.checkin..reservation.checkout
      if date_interval.include?(checkin) || date_interval.include?(checkout)
        self.errors.add :guest_id, "the chosen dates aren't available"
      end
    end

  end
end
