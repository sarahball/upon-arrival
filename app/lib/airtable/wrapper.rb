class Airtable::Wrapper
  def self.find_sheet(table_name)
    client.table("appAKFBlzIeNlvnVl", table_name)
  end
  
  def self.client
    @airtable_wrapper__client ||= Airtable::Client.new(ENV['AIRTABLE_API'])
  end

  def self.find_or_create_card(sheet: nil, category: nil, &block)
    find_sheet(sheet).select(formula: "IF(Category = '#{category}', {Display?} = 1)").each do |row|
      row.destinations.each do |destination_airtable_id|
        row.departures.each do |departure_airtable_id|
          Card.find_or_create_by({
            category: sheet,
            title: category,
            destination: Destination.where(airtable_id: destination_airtable_id).first,
            departure: Departure.where(airtable_id: departure_airtable_id).first
          }) do |card|
            card.highlight = (row.fields['Highlight'] || '').strip
            card.body = (row.fields['Introduction'] || '').strip

            row.fields.reject { |k, v| ['Category', 'Departures', "Destinations", "Display?", "Highlight", "Introduction", "id"].include?(k) }.each do |key, value|
              card.body += "\n\n" + '##' + key + "\n" + value
            end

            card.body.strip!

            block.call(card, row) if block.present?
          end
        end
      end
    end
  end
end
