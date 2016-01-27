class AddStudentToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :student_id, :integer
  end
end
