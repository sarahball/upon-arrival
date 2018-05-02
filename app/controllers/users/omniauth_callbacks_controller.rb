class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    raise request.env["omniauth.auth"].inspect
  end
end
