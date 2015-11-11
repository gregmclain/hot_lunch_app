ActiveAdmin.register User do
  actions :all, :except => [:new]
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

  index do
    selectable_column
    id_column
    column :email
    column :admin
    column :created_at
    column :updated_at
    actions
  end

  filter :email_cont, label: 'Email'

  form do |f|
    f.inputs "User" do
      f.input :email
      f.input :admin
    end

    f.actions
  end

  controller do
    def permitted_params
      #params.permit(:blog => [:name, :description])
      params.permit! # allow all parameters
    end
  end

end
