class AddMonthToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :month, :integer
  end
end
