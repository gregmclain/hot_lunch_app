ActiveAdmin.register Milk do

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
    column :first_name, label: "First Name" do |milk| milk.student.first_name if milk.student end
    column "Last Name" do |milk| milk.student.last_name if milk.student end
    column "Grade" do |milk| milk.student.grade if milk.student end
    column :month do |milk| Date::MONTHNAMES[milk.month] if milk.month end
    column :milk_type
    actions
  end

  filter :student_first_name_cont, label: 'First Name'
  filter :student_last_name_cont, label: 'Last Name'
  filter :student_grade_eq, label: 'Grade'

  controller do
    def permitted_params
      #params.permit(:blog => [:name, :description])
      params.permit! # allow all parameters
    end
  end
end