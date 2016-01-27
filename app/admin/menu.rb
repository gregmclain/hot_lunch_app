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

  show do |menu|
    attributes_table :id, :menu_date
    menu.items.each do |item|
      h3 item.name
    end
  end

  form do |f|
    f.inputs "Menu" do
      f.input :menu_date, as: :date_picker, :input_html => { :value => Date.today.at_beginning_of_month.next_month}
      f.input :item_ids, label: "Items", as: :check_boxes, :multiple => true,
              collection: Item.order("CASE WHEN category = 'Entree' THEN '1'
                                      WHEN category = 'Side' THEN '2'
                                      WHEN category = 'Dessert' THEN '3'
                                      ELSE category END ASC, name ASC").map{|u| ["#{u.name}", u.id]}
    end
    f.actions
  end

  controller do
    def permitted_params
      #params.permit(:blog => [:name, :description])
       params.permit! # allow all parameters
    end
  end

  filter :menu_date
  filter :items
end
