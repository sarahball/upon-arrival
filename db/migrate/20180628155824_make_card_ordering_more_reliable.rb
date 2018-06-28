class MakeCardOrderingMoreReliable < ActiveRecord::Migration[5.2]
  def self.up
    change_column :cards, :position, :integer, default: 1

    Card.reset_column_information

    Destination.all.each do |destination|
      destination.cards.order(position: :asc).each.with_index(1) do |card, index|
        card.update_column :position, index
      end
    end
  end

  def self.down
    change_column :cards, :position, :integer, default: 0
  end
end
