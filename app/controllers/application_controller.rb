class ApplicationController < ActionController::Base
  private
  helper_method :page_title_scope, :page_title_i18n_interpolations
  def page_title_scope; end
  def page_title_i18n_interpolations; end

  helper_method :body_classes
  def body_classes
    'application'
  end

  def user_for_paper_trail
    if current_user
      { user: current_user.id } 
    elsif current_admin
      { admin: current_admin.id }
    else
      {}
    end
  end
end
