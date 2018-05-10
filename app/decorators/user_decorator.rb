class UserDecorator < ApplicationDecorator
  delegate_all

  def description
    redactor_sanitize(object.description)
  end

  def website_url
    h.link_to object.website_url, object.website_url
  end

  def profile_image_url
    h.image_tag object.profile_image_url
  end
end
