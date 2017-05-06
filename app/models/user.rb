class User < ApplicationRecord
  has_many :bookings
  has_many :tours

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true,
  validates :passord, presence: true,
  validates :email, presence: true,
  validates :phone, presence: true,

end
