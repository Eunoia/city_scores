class AddMoreIndexesToCosts < ActiveRecord::Migration[5.1]
  def change
  	add_index :costs, :left_id
  	add_index :costs, :right_id
  end
end
