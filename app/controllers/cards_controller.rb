class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit
  
  def edit; end

  def update
    return render :edit unless resource.update_attributes(resource_params)
    redirect_to destination_path(departure_id: resource.departure&.slug || 'anywhere', destination_id: resource.destination.slug), notice: t('.notice')
  end

  private
  # I inherit this class, then just override the resource_class and resource_params methods.
  def resource_class
    Card
  end

  def resource_params
    params.require(:card).permit(:title, :highlight, :body)
  end

  # Sometimes I override the resource method also if I need to scope things off 
  # the current users and such.
  helper_method :resource
  def resource
    @resource ||= resource_class.find(params[:id]).decorate
  end
end
