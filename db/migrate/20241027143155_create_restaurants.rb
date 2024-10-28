class CreateRestaurants < ActiveRecord::Migration[7.2]
  def change
    create_table :restaurants do |t|
      t.string :corporate_name
      t.string :brand_name
      t.string :registration_number
      t.string :full_address
      t.string :city
      t.string :state
      t.string :phone_number
      t.string :email
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
