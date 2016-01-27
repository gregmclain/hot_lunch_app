class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :student

  def self.update_monthly_charge(student, month)
    transaction = Transaction.find_by(student_id: student.id, transaction_type: "Charge", month:month)
    total = Order.where('extract(month from order_date) = ? AND student_id = ?', month, student.id).sum(:price)

    if transaction != nil
      transaction.update(amount: total)
    else
      @transaction = student.user.transactions.new
      @transaction.student = student
      @transaction.amount = total
      @transaction.transaction_type = "Charge"
      @transaction.month = month
      @transaction.save
    end
  end

end
