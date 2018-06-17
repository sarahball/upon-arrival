ActiveAdmin.register Destination do
  decorate_with DestinationDecorator

  config.sort_order = ['name_asc']

  permit_params :name, :slug, :country_code, :factbook_path, :show_weather

  filter :name

  index do
    column :name
    column :slug
    column :country_code
    column :factbook_path
    column :show_weather
    column :updated_at
    actions
  end

  show do
    attributes_table :name, :slug, :country_code, :airtable_id, :created_at, :updated_at

    panel "Cards" do
      table_for resource.cards do
        column :category
        column :title
        column :departure
        column :actions do |card|
          link_to 'Edit', url_for([:edit, :admin, card])
        end
      end
    end

    active_admin_comments
  end
end
