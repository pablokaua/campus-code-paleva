class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :calories
      t.references :restaurant, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
