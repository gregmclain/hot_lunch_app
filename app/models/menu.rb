class Menu < ActiveRecord::Base

  has_many :menu_items, dependent:   :destroy
  has_many :items, through: :menu_items

  accepts_nested_attributes_for :items, reject_if: :all_blank
  accepts_nested_attributes_for :menu_items, :allow_destroy => true

  def clone!
    cloned_menu = self.dup
    cloned_menu.items = self.items

    cloned_menu.save!

    cloned_menu
  end

end
