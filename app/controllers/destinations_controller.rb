class DestinationsController < ApplicationController
  layout 'landing'

  def show
  end

  private
  helper_method :destination
  def destination
    @destination ||= Destination.find(params[:destination_id])
  end

  helper_method :departure
  def departure
    @departure ||= Departure.find(params[:departure_id])
  end

  def page_title_i18n_interpolations
    {
      departure: departure.title,
      destination: destination.title,
    }
  end

  def body_classes
    "result departure-#{departure.slug} destination-#{destination.slug}"
  end
end
