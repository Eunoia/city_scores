class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.string :name
      t.string :short_name
      t.decimal :lat
      t.decimal :lon
      t.integer :region_id
      t.integer :capacity
      t.text :rental_url

      t.timestamps
    end
  end
end
