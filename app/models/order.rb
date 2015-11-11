class Order < ActiveRecord::Base
  belongs_to :student
  has_many :order_items, dependent:   :destroy
  has_many :items, through: :order_items

  accepts_nested_attributes_for :order_items,
                                :reject_if => :all_blank,
                                :allow_destroy => true

  ONE_ENTREE_PRICE = 4.75
  TWO_ENTREE_PRICE = 5.75
  DAILY_DISCOUNT = 0.25

  def calculate_and_store_price
    if self.entree_quantity == 2
      self.price = TWO_ENTREE_PRICE
    else
      self.price = ONE_ENTREE_PRICE
    end
  end

  def self.adjust_orders_for_discount(student, month)
    #@monthly_orders = Order.where('extract(month from order_date) = ? AND student_id = ?', month, student.id)
    #@monthly_orders.update_all(:price => )
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |order|
        csv << order.attributes.values_at(*column_names)
      end
    end
  end
end
