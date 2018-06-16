class Departure < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:sequentially_slugged, :slugged, :finders]
  
  has_many :cards

  def self.anywhere
    Departure.new(slug: 'anywhere', name: 'Anywhere')
  end
end
