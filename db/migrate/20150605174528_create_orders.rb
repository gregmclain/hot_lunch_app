class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :order_date
      t.references :student, index: true

      t.timestamps null: false
    end
    add_foreign_key :orders, :students
  end
end
