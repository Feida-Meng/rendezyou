class Tourpoint < ApplicationRecord
  belongs_to :tour

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "https://s3.ca-central-1.amazonaws.com/rendezyou-heroku/default imgs/tourpoints_default.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
    validates :tour_point_name, presence: true
  validate :markerdropped?

  def markerdropped?
    if tour_point_laglng == ""
        errors[:base] << "Please drop a marker!"
    end

  end
  def tour_point_img_url
    return avatar.url
  end
end
