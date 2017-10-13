class AddIndexesToCosts < ActiveRecord::Migration[5.1]
  def change
  	add_index :costs, [:left_id, :right_id]
  	add_index :costs, :id
  end
end
