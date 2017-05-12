class Tour < ApplicationRecord
  belongs_to :user
  belongs_to :country
  has_many :bookings, through: :schedules
  has_many :schedules
  has_many :tourpoints

  enum category: [ :nature, :city, :"food & drinks", :recreation, :social, :other]

end
