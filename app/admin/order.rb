ActiveAdmin.register Order do

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

  show do |order|
    attributes_table :id, :order_date
    order.items.each do |item|
      h3 item.name
    end
  end

  index do
    selectable_column
    id_column
    column "First Name" do |order| order.student.first_name if order.student end
    column "Last Name" do |order| order.student.last_name if order.student end
    column "Grade" do |order| order.student.grade if order.student end
    column :order_date
    column :main_quantity
    column :main
    column :side
    column :dessert
    actions
  end

  #filter :first_name
  #filter :last_name
  #filter :grade
  filter :order_date
  filter :main
  filter :side
  filter :dessert

  csv do
    #column "First Name"
    #column "Last Name"
    #column "Grade"
    column :order_date
    column :main_quantity
    column :main
    column :side
    column :dessert
  end

end
