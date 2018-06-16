# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development? || ENV['DURING_RELEASE_SEED_DB'].present?

  # Admin user for admin'ing our DB - pulling in from AirTable will be a PITA.
  AdminUser.find_or_create_by(email: 'admin@uponarriv.al') do |admin|
    admin.password = '12345678'
    admin.password_confirmation = '12345678'
  end

  # Start filling in our DB with the initial departures and destination
  departures = Hash[AirtableWrapper.find_sheet("Departures").all.collect do |departure|
    [departure.id, Departure.find_or_initialize_by(name: departure.name)]
  end]

  destinations = Hash[AirtableWrapper.find_sheet("Destinations").all.collect do |destination|
    [destination.id, Destination.find_or_initialize_by(name: destination.name)]
  end]

  AirtableWrapper.destinations = destinations

  # Build the key information for each destination
  AirtableWrapper.find_sheet("Basics").all.each do |row|
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

  destinations.collect(&:save)

  # For each spreadsheet, make a card for each category.
  ## Culture
  AirtableWrapper.find_or_create_card(sheet: 'Culture', category: 'Languages') do |card, row|
    card.highlight = row.highlight
  end

  AirtableWrapper.find_or_create_card(sheet: 'Culture', category: 'Key Phrases') do |card, row|
    body = <<-EOF
|Phrase|Translation|
|---|---|
|Greeting|#{row.greeting}|
|Yes|#{row.yes}|
|No|#{row.no}|
|Thank You|#{row.thank_you}|
|Excuse Me|#{row.excuse_me}|
EOF
    card.body = body.strip
  end

  AirtableWrapper.find_or_create_card(sheet: 'Culture', category: 'Is English widely spoken?') do |card, row|
    card.hightlight = row.hightlight
  end


  ## Getting Around
  AirtableWrapper.find_or_create_card(sheet: 'Getting Around', category: 'Ridesharing') do |card, row|
    card.hightlight = row.hightlight
    card.body = row.introduction

    # TODO: Has cards and topping up info
  end

  AirtableWrapper.find_or_create_card(sheet: 'Getting Around', category: 'Transport') do |card, row|
    card.hightlight = row.hightlight
    card.body = row.introduction

    # TODO: Has cards and topping up info
  end

  ## Safety
  AirtableWrapper.find_or_create_card(sheet: 'Safety', category: 'Emergency Numbers') do |card, row|
    card.hightlight = row.hightlight
    # TODO: Has more info to import
  end

  AirtableWrapper.find_or_create_card(sheet: 'Safety', category: 'Scams') do |card, row|
    card.body = row.introduction
    # TODO: Has more info to import
  end

  ### TODO: Where's my nearest embassy?

  ## Tech
  AirtableWrapper.find_or_create_card(sheet: 'Tech', category: 'Prepaid SIM') do |card, row|
    card.hightlight = row.hightlight
    card.body = row.introduction
    # TODO: Has more info to import
  end

  ## Money
  ### TODO: Big Mac Index
  AirtableWrapper.find_or_create_card(sheet: 'Money', category: 'Tipping') do |card, row|
    card.hightlight = row.hightlight
    card.body = row.introduction
    # TODO: Has more info to import
  end

  ## Health
  AirtableWrapper.find_or_create_card(sheet: 'Health', category: 'Can you drink the tap water?') do |card, row|
    card.hightlight = row.hightlight
  end

  AirtableWrapper.find_or_create_card(sheet: 'Health', category: 'Reputable hospital') do |card, row|
    card.hightlight = row.hightlight
    card.body = row.introduction
  end
end
