class Item < ApplicationRecord
  belongs_to :restaurant
  has_one_attached :photo
  has_many :item_tags
  has_many :tag_models, through: :item_tags

  enum :status, { active: 0, inactive: 1 }

  validates :name, :description, presence: true
  validates :calories, numericality: { only_integer: true }, allow_nil: true

  validate :acceptable_image

  private 
  def acceptable_image
    errors.add(:photo, "não deve ser vazia") unless photo.attached?

    acceptable_types = ["image/jpeg", "image/png", "image/webp", "image/jpg"]
    unless acceptable_types.include?(photo.content_type)
      errors.add(:photo, "deve ser JPEG ou PNG")
    end
  end
end
