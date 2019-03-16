class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  mount_uploader :photo, PhotoUploader

  validates :image, presence: true, allow_nil: true
  validates :photo, presence: true, allow_nil: true
  validates :name, presence: true, uniqueness: true

  validate :image_xor_photo

  private

  def image_xor_photo
    unless image.blank? ^ photo.blank?
      errors.add(:base, "Specify a image url or upload a photo, not both but at least one")
    end
  end
end
