class Menu < ActiveRecord::Base

  has_many :menu_items, dependent:   :destroy
  has_many :items, through: :menu_items

  accepts_nested_attributes_for :items
  accepts_nested_attributes_for :menu_items
end
