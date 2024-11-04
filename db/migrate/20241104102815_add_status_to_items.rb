class AddStatusToItems < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :status, :integer, default: 0
  end
end
