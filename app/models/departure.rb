class Departure < JSONRecord
  def slug
    data['slug']
  end

  def title
    data['title']
  end

  def currency
    ISO3166::Country.new(data['country']).currency
  end

  def languages
    ISO3166::Country.new(data['country']).languages
  end
end
