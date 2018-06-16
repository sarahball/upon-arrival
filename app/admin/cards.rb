ActiveAdmin.register Card do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  decorate_with CardDecorator

  actions :index, :show
  
  config.sort_order = ['position_asc']

  sortable

  scope :departure_is_set
  scope :departure_is_anywhere

  index do
    # This adds columns for moving up, down, top and bottom.
    sortable_handle_column

    column :category
    column :title
    column :destination
    column :departure
    column :highlight
    column :body
    column :position
    actions
  end
end
