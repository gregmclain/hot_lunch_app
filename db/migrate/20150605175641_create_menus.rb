class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.date :menu_date

      t.timestamps null: false
    end
  end
end
