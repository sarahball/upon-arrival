class LandingController < ApplicationController
  def index; end

  private
  def body_classes
    "locations locations-#{Destination.order("RANDOM()").first.slug}"
  end
end
