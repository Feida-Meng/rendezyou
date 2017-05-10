class Tour < ApplicationRecord
  belongs_to :user
  has_many :bookings, through: :schedules
  has_many :schedules


  COUNTRIES_AND_CITIES = {Canada: ['Toronto','Vancouver','Calgory','Edmonton','Ottawa'], China:['Beijing','Shanghai','Zhengzhou','HK','Zhengzhou'], Philippines:['Manila','Davao','Quezon','Caloocan','Cebu'], EU:['Pairs','Berlin','London','Moscow','Rome']}


end
