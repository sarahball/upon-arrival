class Card < ApplicationRecord
  belongs_to :destination
  belongs_to :departure, optional: true

  scope :by_position, ->{ order(position: :asc) }

  scope :departure_is_set, ->{ where.not(departure_id: nil) }
  scope :departure_is_anywhere, ->{ where(departure_id: nil) }

  default_scope { by_position }
  acts_as_list scope: [:destination_id]
end
