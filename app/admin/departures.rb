ActiveAdmin.register Departure do
  decorate_with DepartureDecorator

  config.sort_order = ['name_asc']

  permit_params :name, :slug, :country_code

  filter :name

  index do
    column :name
    column :slug
    column :country_code
    column :updated_at
    actions
  end
end
