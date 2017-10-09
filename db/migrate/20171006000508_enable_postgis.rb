class EnablePostgis < ActiveRecord::Migration[5.1]
  def change
  	execute "CREATE EXTENSION postgis;"
  end
end
