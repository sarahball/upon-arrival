class Card < ApplicationRecord
  belongs_to :destination
  belongs_to :departure, optional: true

  scope :by_position, ->{ order(position: :asc) }
end
