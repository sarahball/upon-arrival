ActiveAdmin.register User do
  decorate_with UserDecorator

  actions :index, :show

  index do
    column :username
    column :email
    column :name
    column :current_sign_in_at
    column :current_sign_in_ip
    column :created_at
    column :updated_at
    actions
  end
end
