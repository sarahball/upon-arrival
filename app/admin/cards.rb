ActiveAdmin.register Card do
  decorate_with CardDecorator

  permit_params :destination_id, :departure_id, :category, :title, :highlight, :body

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

  form do |f|
    f.inputs do
      f.input :destination, include_blank: false
      f.input :departure
      f.input :category
      f.input :title
      f.input :highlight
      f.input :body
    end

    f.actions
  end
end
