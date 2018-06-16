class Card < ApplicationRecord
  belongs_to :destination
  belongs_to :departure, optional: true
end
