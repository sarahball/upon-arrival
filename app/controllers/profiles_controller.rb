class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:update, :edit]

  def edit; end

  def update
    redirect_to({ action: :edit }, { notice: t('.notice') })
  end

  private
  helper_method :resource
  def resource
    @resource ||= User.find(current_user.id)
  end
end
