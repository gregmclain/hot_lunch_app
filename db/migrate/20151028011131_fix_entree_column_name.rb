class FixEntreeColumnName < ActiveRecord::Migration
  def change
    rename_column :orders, :main, :entree
    rename_column :orders, :main_quantity, :entree_quantity
  end
end
