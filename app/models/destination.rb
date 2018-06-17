class Destination < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:sequentially_slugged, :slugged, :finders]

  scope :by_name, ->{ order(name: :asc) }

  has_many :cards

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
