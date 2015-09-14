class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :order_date
      t.references :student, :index => true

      t.timestamps null: false
    end

    add_index :orders, [:order_date, :student_id], :unique => true

  end
end
