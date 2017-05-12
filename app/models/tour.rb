class Tour < ApplicationRecord
  belongs_to :user
  belongs_to :country
  has_many :bookings, through: :schedules
  has_many :schedules
  has_many :tourpoints
  validates :duration_in_ms, numericality: true

  #converting duration input to ms before saving
  before_save { |tour| tour.duration_in_ms = (tour.duration_in_ms) * 3600000 }


  def self.search(search)
    where("name LIKE ? OR description LIKE ? OR category LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
  end


  enum category: [ :nature, :city, :"food & drinks", :recreation, :social, :other]

end
