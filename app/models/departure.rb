class Departure < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:sequentially_slugged, :slugged, :finders]
  
  has_many :cards

  def self.anywhere
    Departure.new(slug: 'anywhere', name: 'Anywhere')
  end

  private
  def currency
    ISO3166::Country.new(data['country_code']).currency
  end

  def offical_languages
    ISO3166::Country.new(data['country_code']).languages.collect do |language|
      I18nData.languages[language.upcase]
    end
  end
end
