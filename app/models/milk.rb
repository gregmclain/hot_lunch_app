class Milk < ActiveRecord::Base
  belongs_to :student

  PRICE_PER_MILK = 0.45

  def self.milk_types
    ['Chocolate', '2%']
  end

end