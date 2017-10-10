class AddMiscIndexesToStation < ActiveRecord::Migration[5.1]
  def change
  	add_index :stations, :name
		add_index :stations, :region_id
		add_index :scores, :created_at
		add_index :scores, [:created_at, :score]
  end
end
