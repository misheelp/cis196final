class AddCountToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :count, :integer
  end
end
