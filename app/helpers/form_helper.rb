module FormHelper
  def setup_menu(menu)
    3.times { menu.items.build }
    menu
  end
end