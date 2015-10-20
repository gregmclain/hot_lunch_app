class AddQuantityMainSideAndDessertToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :main_quantity, :int
    add_column :orders, :main, :string
    add_column :orders, :side, :string
    add_column :orders, :dessert, :string
  end
end
