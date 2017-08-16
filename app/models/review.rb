class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :rating, :reservation, :description, presence: true
  validate :accepted_reservation?, :checkout_happened?

  def accepted_reservation?
    self.errors.add :guest_id, "your reservation wasn't accepted" unless self.reservation && self.reservation.status == "accepted"
  end

  def checkout_happened?
    self.errors.add :guest_id, "review must be made after checkout" if self.reservation && self.reservation.checkout >= Date.today
  end
end
