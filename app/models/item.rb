class Item < ApplicationRecord
  belongs_to :restaurant

  validates :name, :description, presence: true
  validates :calories, numericality: { only_integer: true }, allow_nil: true
end
