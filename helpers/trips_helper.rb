module TripsHelper
  def departures
    @departures ||= @app.data.departures.collect do |country_code, activated|
      if activated
        ISO3166::Country.new(country_code)
      else
        nil
      end
    end.compact
  end

  def destinations
    @destinations ||= @app.data.destinations.collect do |destination_code, destination_data|
      country_data = ISO3166::Country.new(destination_data.country)
      @app.data.destinations[destination_code].merge({
        latitude_dec: country_data.latitude_dec,
        longitude_dec: country_data.longitude_dec,
        currency: country_data.currency,
        languages: country_data.languages
      })
    end
  end
end
