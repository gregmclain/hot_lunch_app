class CreateDeadlines < ActiveRecord::Migration
  def change
    create_table :deadlines do |t|
      t.integer :month
      t.datetime :deadline_date
    end
  end
end
