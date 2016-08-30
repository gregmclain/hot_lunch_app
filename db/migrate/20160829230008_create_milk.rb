class CreateMilk < ActiveRecord::Migration
  def change
    create_table :milks do |t|
      t.integer :month
      t.integer :milk_type
      t.references :student, index: true
    end
    add_foreign_key :milks, :students
  end
end
