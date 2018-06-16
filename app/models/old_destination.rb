class OldDestination < JSONRecord
  def slug
    data['slug']
  end

  def title
    data['title']
  end

  def cards(departure)
    [sim, emergency_numbers, ridesharing, money(departure), languages, health, weather].compact
  end

  def sim
    return nil unless data['sim'].present?

    Destination::Card.new({
      type: 'tech',
      title: 'Prepaid SIM',
      subtitle: data['sim_highlight'],
      body: data['sim_intro'],
      tabular_data: data['sim']
    })
  end

  def emergency_numbers
    return nil unless data['emergency_numbers'].present?

    Destination::Card.new({
      type: 'safety',
      title: 'Emergency Services',
      subtitle: data['emergency_highlight'],
      tabular_data: data['emergency_numbers']
    })
  end

  def ridesharing
    return nil unless data['ridesharing'].present?

    Destination::Card.new({
      type: 'getting-around',
      title: 'Ridesharing',
      subtitle: 'Grab, Uber',
      body: data['ridesharing'],
    })
  end

  def money(departure)
    # Maybe use the Big Mac Index as an indicator?
    # https://www.quandl.com/data/ECONOMIST-The-Economist-Big-Mac-Index?keyword=Germany
    Destination::Card.new({
      type: 'money',
      title: 'Is the exchange rate favorable?',
      subtitle: "#{departure.currency.code} to #{currency.code} is good"
    })
  end

  def languages
    Destination::Card.new({
      type: 'culture',
      title: 'Languages',
      subtitle: offical_languages.to_sentence,
      body: '<p>English is widely spoken in tourist-friendly areas.</p>'
    })
  end

  def health
    Destination::Card.new({
      type: 'health',
      title: 'Can I drink the tap water?',
      subtitle: 'No',
    })
  end

  def weather
    Destination::Card.new({
      type: 'weather',
      title: 'Typical Weather',
      subtitle: 'Tropical',
      body: '<p>Mid-May to September: rainy, warm, cloudy southwest monsoon</p><p>November to Mid-March: dry, cool northeast monsoon</p>'
    })
  end

  private
  def currency
    ISO3166::Country.new(data['country']).currency
  end

  def offical_languages
    ISO3166::Country.new(data['country']).languages.collect do |language|
      I18nData.languages[language.upcase]
    end
  end
end
