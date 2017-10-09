class CreateCosts < ActiveRecord::Migration[5.1]
  def change
    create_table :costs do |t|
      t.integer :left_id
      t.integer :right_id
      t.decimal :distance
      t.decimal :haversine
      t.decimal :time
      t.text :polyline
      t.integer :mode

      t.timestamps
    end
  end
end
