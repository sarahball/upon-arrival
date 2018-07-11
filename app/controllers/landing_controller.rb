class LandingController < ApplicationController
  def index; end

  private
  def body_classes
    "locations locations-#{Destination.by_random.first.slug}"
  end
end
