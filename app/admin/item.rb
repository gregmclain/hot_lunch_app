ActiveAdmin.register Item do

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

  form do |f|
    f.inputs "Item" do
      f.input :name
      f.input :description
      f.input :category, as: :select, collection: ['Entree', 'Side', 'Dessert']
    end

    f.actions
  end

  controller do
    def permitted_params
      #params.permit(:blog => [:name, :description])
      params.permit! # allow all parameters
    end
  end

  filter :name_cont, label: 'Name'
  filter :category, as: :select, collection: ['Entree', 'Side', 'Dessert']
end