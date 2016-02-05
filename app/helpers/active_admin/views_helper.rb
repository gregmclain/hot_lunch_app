module ActiveAdmin::ViewsHelper
  def filter_menu_by_category(menu, category)
    items = menu.items.select{ |item| item.category == category }
    items.map { |item| item.name }
  end
end