class TagModel < ApplicationRecord
  belongs_to :restaurant

  validates :description, presence: true
  validates :description, uniqueness: true
end
