class User < ApplicationRecord

  has_secure_password

  has_many :bookings
  has_many :tours
  validates :name, :username, :email, :phone, :password, presence: true
  validates :username, :email, :phone, uniqueness: true
  validates :password, length: { in: 4..20 }
  validates :email, format: { with: /[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+/i }
  validates :phone, length: { in: 10..15 }, format: { with: /[\d]+/, message: 'can only contain numbers'}

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "https://s3.ca-central-1.amazonaws.com/rendezyou-heroku/default imgs/default user profile.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def booked_tours
    tours = []
    bookings.each do |b|
      # byebug
      t = Tour.find( Schedule.find( (b.schedule_id) ).tour_id )
      if !tours.include?(t)
        tours << Tour.find( Schedule.find( (b.schedule_id) ).tour_id )
      end
    end
    return tours

  end

  def booked_schedules_ids
    schedules_ids = []
    bookings.map { |b|  schedules_ids << b.schedule_id }
    return schedules_ids
  end

end
