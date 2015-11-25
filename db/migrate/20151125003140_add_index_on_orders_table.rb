class AddIndexOnOrdersTable < ActiveRecord::Migration
  def change
    add_index :orders, [:order_date, :student_id], :unique => true
  end
end
