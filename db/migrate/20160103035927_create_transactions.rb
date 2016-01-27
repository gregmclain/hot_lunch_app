class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :student_id
      t.string :transaction_type
      t.float :amount

      t.timestamps null: false
    end
  end
end
