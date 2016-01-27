ActiveAdmin.register Transaction do
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
    f.inputs "Transaction" do
      f.input :user
      f.input :student
      f.input :transaction_type, as: :select, collection: ['Charge', 'Payment']
      f.input :month
      f.input :amount
      f.input :notes
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :user, label: "User" do |transaction| transaction.user.email if transaction.user end
    column "First Name" do |transaction| transaction.student.first_name if transaction.student end
    column "Last Name" do |transaction| transaction.student.last_name if transaction.student end
    column :transaction_type
    column :month do |transaction| Date::MONTHNAMES[transaction.month] if transaction.month end
    column :notes
    column :amount
    actions
  end

  filter :user
  filter :student_first_name_cont, label: 'First Name'
  filter :student_last_name_cont, label: 'Last Name'
  filter :transaction_type, as: :select, collection: ['Charge', 'Payment']

  controller do
    def permitted_params
      #params.permit(:blog => [:name, :description])
      params.permit! # allow all parameters
    end
  end

end
