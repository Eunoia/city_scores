class AddGeogToStation < ActiveRecord::Migration[5.1]
  def change
  	add_column :stations, :geo, :point, :srid => 3785
  	add_index :stations, :geo, using: :gist
  end
end
