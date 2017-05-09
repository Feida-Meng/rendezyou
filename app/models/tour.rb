class Tour < ApplicationRecord
  belongs_to :user
  has_many :bookings, through: :schedules
  has_many :schedules
  accepts_nested_attributes_for :schedules

    COUNTRIES_AND_CITIES = {Canada:['Toronto','Vancouver','Calgory','Edmonton','Ottawa'],China:['Beijing','Shanghai','Zhengzhou','HK','Zhengzhou'],Philippines:['Manila','Davao','Quezon','Caloocan','Cebu'],EU:['Pairs','Berlin','London','Moscow','Rome']}

    COUNTRIES = []
    COUNTRIES_AND_CITIES.each do |k,v|
      COUNTRIES << [k,k]
    end

    def self.cities(country)
      cities = []
      COUNTRIES_AND_CITIES[:country].each do |city|
        cities << [city,city]
      end
    end




end
