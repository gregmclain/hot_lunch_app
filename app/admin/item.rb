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

  controller do
    def permitted_params
      #params.permit(:blog => [:name, :description])
      params.permit! # allow all parameters
    end
  end

  filter :name
  filter :category
end