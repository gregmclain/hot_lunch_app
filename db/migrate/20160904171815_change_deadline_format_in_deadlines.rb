class ChangeDeadlineFormatInDeadlines < ActiveRecord::Migration
  def change
    change_column(:deadlines, :deadline_date, :datetime)
  end
end
