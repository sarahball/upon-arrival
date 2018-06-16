class Airtable::Seeds
  def self.departures!
    Airtable::Wrapper.find_sheet("Departures").select(formula: 'Name != "Anywhere"').each do |departure|
      Departure.find_or_create_by({
        airtable_id: departure.id,
        name: departure.name,
        slug: departure.name.parameterize,
        country_code: ISO3166::Country.find_by_name(departure.name)[1]['alpha2']
      })
    end
  end

  def self.destinations!
    destinations = Hash[Airtable::Wrapper.find_sheet("Destinations").select(formula: 'Name != "Anywhere"').collect do |destination|
      [destination.id, Destination.find_or_initialize_by(airtable_id: destination.id, name: destination.name)]
    end]

    # Build the key information for each destination
     Airtable::Wrapper.find_sheet("Basics").all.each do |row|
      row.destinations.each do |destination_airtable_id|
        if row.category == 'slug'
          destinations[destination_airtable_id].slug = row.data
        elsif row.category == 'country'
          destinations[destination_airtable_id].country_code = row.data
        elsif row.category == 'factbook path'
          destinations[destination_airtable_id].facebook_path = row.data
        end
      end
    end

    destinations.each do |key, object|
      object.save
    end
  end
end
