class AddPKeyAndFKeyIndexesToStation < ActiveRecord::Migration[5.1]
  def change
  	add_index :stations, :id
  	add_index :scores, :station_id
  end
end
