class ApplicationController < ActionController::Base
  private
  helper_method :page_title_scope, :page_title_i18n_interpolations
  def page_title_scope; end
  def page_title_i18n_interpolations; end

  helper_method :body_classes
  def body_classes
    'application'
  end
end
