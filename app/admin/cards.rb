ActiveAdmin.register Card do
  decorate_with CardDecorator

  permit_params :destination_id, :departure_id, :category, :title, :highlight, :body

  config.sort_order = ['position_asc']

  sortable

  scope :departure_is_set
  scope :departure_is_anywhere

  sidebar :versions, partial: 'versions', only: [:show, :edit]

  action_item :revert_version, only: :show do
    if params[:version].present?
      link_to 'Revert Card', [:revert_version, :admin, resource, {version: params[:version]}], method: :patch
    end
  end

  member_action :revert_version, method: :patch do
    resource.save!
    redirect_to url_for([:admin, resource])
  end

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

  controller do

    def find_resource
      tmp_resource = scoped_collection.where(id: params[:id]).includes(versions: :item).first!
      tmp_resource = tmp_resource.versions.find(params[:version]).reify if params[:version]
      tmp_resource
    end
  end
end
