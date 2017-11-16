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
        languages: country_data.languages,
        climate: get_climate(destination_data.factbook_path)
      })
    end
  end

  def get_climate(factbook_path)
    climate = app.cache "factbook-from-github/#{factbook_path}" do
      uri = URI("https://raw.githubusercontent.com/opendatajson/factbook.json/2ea746ff6dcf3a9b8f47534014937b68b8c915dd/#{factbook_path}.json")
      response = Net::HTTP.get(uri)
      factbook = JSON.parse(response)
      factbook['Geography']['Climate']['text']
    end

    "#{climate.capitalize}."
  end
end
