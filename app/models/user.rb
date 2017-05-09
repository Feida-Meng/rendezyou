class User < ApplicationRecord

  has_secure_password

  has_many :bookings
  has_many :tours

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  # validates :password, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true

  def booked_tours
    tours=[]
    bookings.each do |b|
      # byebug
      t = Tour.find( Schedule.find( (b.schedule_id) ).tour_id )
      if !tours.include?(t)
        tours << Tour.find( Schedule.find( (b.schedule_id) ).tour_id )
      end
    end
    return tours

  end

end
