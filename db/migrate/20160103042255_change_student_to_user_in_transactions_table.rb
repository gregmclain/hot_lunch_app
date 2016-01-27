class ChangeStudentToUserInTransactionsTable < ActiveRecord::Migration
    def change
      rename_column :transactions, :student_id, :user_id
    end
end
