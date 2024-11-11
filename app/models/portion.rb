class Portion < ApplicationRecord
  belongs_to :item

  validates :description, presence: true
  validates :current_price, presence: true
  validates :description, uniqueness: {scope: :item_id}
end
