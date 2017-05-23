class Tour < ApplicationRecord
  belongs_to :user
  belongs_to :country
  has_many :bookings, through: :schedules
  has_many :schedules
  has_many :tourpoints
  has_many :reviews
  has_attached_file :tourpic, styles: { medium: "300x300>", thumb: "100x100>", big: "400x400>"}, default_url: ActionController::Base.helpers.asset_path('top.jpg')

  validates :duration_in_ms, numericality: { greater_than: 0 }
  validates_attachment_content_type :tourpic, content_type: /\Aimage\/.*\z/

  # converting duration input to ms before saving
  # before_save { |tour| tour.duration_in_ms = (tour.duration_in_ms) * 3600000 }



  def country_name #for json
    Country.find(country_id).name
  end

  def self.search(search)
    keywords = search.split.map { |key| "%#{key}%" }
    where("name ILIKE any ( array[?] ) OR description ILIKE any ( array[?] ) OR category::text ILIKE any ( array[?] ) OR rendezvous_point ILIKE any ( array[?] ) OR country_id = ?", keywords, keywords, keywords, keywords ,Country.where("name ILIKE any ( array[?] )", keywords ).ids.first)
  end


  def duration_in_hr(duration_in_ms=0)
    duration_in_ms / 3600000
  end

  enum category: [ :Nature, :"City tour", :"Food & drinks", :Recreation, :Social, :Other]

end
