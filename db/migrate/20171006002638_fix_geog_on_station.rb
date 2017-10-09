class FixGeogOnStation < ActiveRecord::Migration[5.1]
  def change
		remove_column :stations, :geo
		add_column :stations, :geog, :geography, limit: {:srid=>4326, :type=>"point", :geographic=>true}#, null: false
		add_index :stations, :geog, using: :gist
  end
end
