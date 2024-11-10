class TagModel < ApplicationRecord
  belongs_to :restaurant
  has_many :item_tags
  has_many :items, through: :item_tags

  validates :description, presence: true
  validates :description, uniqueness: {scope: :restaurant_id}
end
