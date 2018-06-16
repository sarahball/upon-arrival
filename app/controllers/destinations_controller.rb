class DestinationsController < ApplicationController
  def show
  end

  private
  helper_method :destination
  def destination
    @destination ||= Destination.find(params[:destination_id])
  end

  helper_method :departure
  def departure
    @departure ||= params[:departure_id] == 'anywhere' ? Departure.anywhere : Departure.find(params[:departure_id])
  end

  def page_title_i18n_interpolations
    {
      departure: departure.name,
      destination: destination.name,
    }
  end

  def body_classes
    "result departure-#{departure.slug} destination-#{destination.slug}"
  end
end
