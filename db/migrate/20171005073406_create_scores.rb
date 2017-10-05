class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.integer :station_id
      t.integer :score
      t.datetime :created_at

      t.timestamps
    end
  end
end
