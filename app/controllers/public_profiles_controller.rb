class PublicProfilesController < ApplicationController
  def show; end

  private
  helper_method :resource
  def resource
    @resource ||= User.find_by!(username: params[:username]).decorate
  end

  def page_title_i18n_interpolations
    {
      resource: resource
    }
  end
end
