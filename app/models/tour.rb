class Tour < ApplicationRecord
  belongs_to :user
  has_many :bookings, through: :schedules
  has_many :schedules
  validates :duration_in_ms, numericality: true

  #converting duration input to ms before saving
  before_save { |tour| tour.duration_in_ms = (tour.duration_in_ms) * 3600000 }


  COUNTRIES_AND_CITIES = {Canada: ['Toronto','Vancouver','Calgory','Edmonton','Ottawa'], China:['Beijing','Shanghai','Zhengzhou','HK','Zhengzhou'], Philippines:['Manila','Davao','Quezon','Caloocan','Cebu'], EU:['Pairs','Berlin','London','Moscow','Rome']}


end
