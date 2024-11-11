class CreatePortions < ActiveRecord::Migration[7.2]
  def change
    create_table :portions do |t|
      t.references :item, null: false, foreign_key: true
      t.string :description
      t.decimal :current_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
