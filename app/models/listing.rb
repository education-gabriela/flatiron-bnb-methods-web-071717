class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, :listing_type, :title, :description, :price, :neighborhood, presence: true

  after_create :change_user_status
  before_destroy :change_host_status_after_destroy

  def average_review_rating
    self.reviews.average(:rating)
  end

  def change_user_status
    self.host.toggle!(:host)
  end

  def change_host_status_after_destroy
    if Listing.all.where(host: self.host).where.not(id: self).empty?
      self.host.update(host: false)
    end
  end

  def available(start_date, end_date)
    interval = start_date..end_date
    reservations = self.reservations.where(checkin: interval) | self.reservations.where(checkout: interval)
    reservations.empty?
  end

end
