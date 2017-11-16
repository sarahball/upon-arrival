module WeatherHelper
  def weather(destination)
    @weather ||= {}
    @weather[destination.slug] ||= get_weather(destination)
  end

  def get_weather(destination)
    app.cache "dark-sky/#{destination.latitude_dec},#{destination.longitude_dec}" do
      uri = URI("https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/#{destination.latitude_dec},#{destination.longitude_dec}?units=si&exclude=minutely,currently,flags")
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  end

  def weather_temperature_high(destination)
    "#{weather(destination)['daily']['data'].first['temperatureHigh']} °c"
  end

  def weather_temperature_low(destination)
    "#{weather(destination)['daily']['data'].first['temperatureLow']} °c"
  end

  def weather_today_summary(destination)
    weather(destination)['hourly']['data'].first['summary']
  end

  def weather_today_icon(destination)
    weather(destination)['daily']['icon']
  end

  def weather_typical(destination)
    destination.climate
  end
end
