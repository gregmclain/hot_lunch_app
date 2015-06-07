class Order < ActiveRecord::Base
  belongs_to :student
  has_many :order_items, dependent:   :destroy
  has_many :items, through: :order_items

  accepts_nested_attributes_for :order_items,
                                :reject_if => :all_blank,
                                :allow_destroy => true
end
