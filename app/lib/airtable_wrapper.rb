class AirtableWrapper
  def self.find_sheet(table_name)
    airtable_client.table("appAKFBlzIeNlvnVl", table_name)
  end
  
  def self.client
    @airtable_wrapper__client ||= Airtable::Client.new(ENV['AIRTABLE_API'])
  end

  def self.find_or_create_card(sheet: nil, category: nil, &block)

    find_sheet(sheet).select(formula: "IF(Category = '#{category}', {Display?} = 1)").each do |row|
      row.destinations.each do |destination_airtable_id|
        Card.find_or_create_by(category: sheet, title: category, destination: destinations[destination_airtable_id]) do |card|
          block.call(card, row)
        end
      end
    end
  end

  def self.destinations=(value)
    @destinations = value
  end

  def self.destinations
    @destinations
  end
end
