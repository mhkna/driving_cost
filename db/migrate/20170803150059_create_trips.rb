class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :origin, null: false
      t.string :destination, null: false
      t.string :car_make, null: false
      t.string :car_model, null: false
      t.integer :car_year, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end
