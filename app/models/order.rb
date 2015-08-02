class Order < ActiveRecord::Base
  belongs_to :student
  has_many :order_items, dependent:   :destroy
  has_many :items, through: :order_items

  accepts_nested_attributes_for :order_items,
                                :reject_if => :all_blank,
                                :allow_destroy => true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |order|
        csv << order.attributes.values_at(*column_names)
      end
    end
  end
end
