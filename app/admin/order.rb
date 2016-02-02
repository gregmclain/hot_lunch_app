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

  menu priority: 1

  show do |order|
    attributes_table :id, :order_date
    order.items.each do |item|
      h3 item.name
    end
  end

  form do |f|
    f.inputs "Order" do
      f.input :student
      f.input :order_date
      f.input :entree_quantity
      f.input :entree, as: :select, :include_blank => true, collection: Item.where(:category => "Entree").map{|u| ["#{u.name}", u.name]}
      f.input :side, as: :select, :include_blank => true, collection: Item.where(:category => "Side").map{|u| ["#{u.name}", u.name]}
      f.input :dessert, as: :select, :include_blank => true, collection: Item.where(:category => "Dessert").map{|u| ["#{u.name}", u.name]}
      f.input :price
      f.input :notes
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :first_name, label: "First Name" do |order| order.student.first_name if order.student end
    column "Last Name" do |order| order.student.last_name if order.student end
    column "Grade" do |order| order.student.grade if order.student end
    column :order_date
    column :entree_quantity
    column :entree
    column :side
    column :dessert
    column :price
    column :notes
    actions
  end


  filter :order_date
  filter :entree_cont, label: 'Entree'
  filter :side_cont, label: 'Side'
  filter :dessert_cont, label: 'Dessert'
  filter :student_first_name_cont, label: 'First Name'
  filter :student_last_name_cont, label: 'Last Name'
  filter :student_grade_eq, label: 'Grade'


  csv do
    column :name, label: "Name" do |order| "#{order.student.first_name} #{order.student.last_name}" if order.student end
    column :grade, label: "Grade" do |order| order.student.grade if order.student end
    column :order_date
    column :entree_quantity
    column :entree
    column :side
    column :dessert
    column :notes
  end

  controller do
    def permitted_params
      #params.permit(:blog => [:name, :description])
      params.permit! # allow all parameters
    end
  end

end
