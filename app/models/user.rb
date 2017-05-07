class User < ApplicationRecord

  has_secure_password

  has_many :bookings
  has_many :tours

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  # validates :password, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true



end
