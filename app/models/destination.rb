class Destination < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:sequentially_slugged, :slugged, :finders]

  has_many :cards
end
