class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :origin, null: false
      t.string :destination, null: false
      t.integer :car_id, null: false

      t.timestamps
    end
  end
end
