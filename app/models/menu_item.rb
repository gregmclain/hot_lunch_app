class MenuItem < ActiveRecord::Base

  belongs_to :menu
  belongs_to :item

  accepts_nested_attributes_for :item
end
