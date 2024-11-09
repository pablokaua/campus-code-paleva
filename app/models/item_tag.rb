class ItemTag < ApplicationRecord
  belongs_to :item
  belongs_to :tag_model

  validates :tag_model_id,  uniqueness: {scope: :item_id}
end
