class Card < ApplicationRecord
  belongs_to :destination
  belongs_to :departure, optional: true

  scope :by_position, ->{ order(position: :asc) }
  scope :with_departure_or_empty, ->(departure){ where('cards.departure_id IS NULL OR cards.departure_id = ?', departure.id)}

  scope :departure_is_set, ->{ where.not(departure_id: nil) }
  scope :departure_is_anywhere, ->{ where(departure_id: nil) }

  default_scope { by_position }
  acts_as_list scope: [:destination_id]

  def type
    category.downcase
  end
end
