class Deadline < ActiveRecord::Base

  def self.passed_deadline?(month, current_time)
    monthly_deadline = Deadline.where(month: month).take
    return current_time >= monthly_deadline.deadline_date
  end

end