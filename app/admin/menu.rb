ActiveAdmin.register Menu do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  menu priority: 2
  actions :all

  member_action :clone, method: :get do
    cloned_menu = resource.clone!

    redirect_to edit_admin_menu_path(cloned_menu)
  end

  action_item(only: :show) { link_to "Make a Copy", clone_admin_menu_path() }


  show do |menu|
    attributes_table :id, :menu_date
    menu.items.each do |item|
      h3 item.name
    end
  end

  form do |f|
    f.inputs "Menu" do
      f.input :menu_date, as: :datepicker
      f.input :item_ids, label: "Entrees", as: :check_boxes, :multiple => true,
              collection: Item.where(:category => "Entree").order("name ASC").map{|u| ["#{u.name}", u.id]}
      f.input :item_ids, label: "Sides", as: :check_boxes, :multiple => true,
              collection: Item.where(:category => "Side").order("name ASC").map{|u| ["#{u.name}", u.id]}
      f.input :item_ids, label: "Desserts", as: :check_boxes, :multiple => true,
              collection: Item.where(:category => "Dessert").order("name ASC").map{|u| ["#{u.name}", u.id]}

    end
    f.actions
  end

  controller do
    def permitted_params
      #params.permit(:blog => [:name, :description])
       params.permit! # allow all parameters
    end
  end

  index do
    selectable_column
    id_column
    column :menu_date
    column "Entrees" do |menu| filter_menu_by_category(menu,'Entree').join(", ") end
    column "Sides" do |menu| filter_menu_by_category(menu,'Side').join(", ") end
    column "Desserts" do |menu| filter_menu_by_category(menu,'Dessert').join(", ") end
    actions defaults: true do |menu|
      link_to 'Copy', clone_admin_menu_path(menu)
    end
  end


  filter :menu_date
  filter :items_name_cont, label: "Item Name"
end
