class ChangeMilkTypeFormatInMilks < ActiveRecord::Migration
  def change
    change_column(:milks, :milk_type, :string)
  end
end
