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
  Airtable::Seeds.departures!
  Airtable::Seeds.destinations!

  # For each spreadsheet, make a card for each category.
  ## Culture
  Airtable::Wrapper.find_or_create_card(sheet: 'Culture', category: 'Languages')
  Airtable::Wrapper.find_or_create_card(sheet: 'Culture', category: 'Key Phrases') do |card, row|
    body = <<-EOF
|Greeting|#{row.greeting}|
|Yes|#{row.yes}|
|No|#{row.no}|
|Thank You|#{row.thank_you}|
|Excuse Me|#{row.excuse_me}|
EOF
    card.body = body.strip
  end
  Airtable::Wrapper.find_or_create_card(sheet: 'Culture', category: 'Is English widely spoken?')

  ## Getting Around
  Airtable::Wrapper.find_or_create_card(sheet: 'Getting Around', category: 'Ridesharing')
  Airtable::Wrapper.find_or_create_card(sheet: 'Getting Around', category: 'Transport')

  ## Safety
  Airtable::Wrapper.find_or_create_card(sheet: 'Safety', category: 'Emergency Numbers')
  Airtable::Wrapper.find_or_create_card(sheet: 'Safety', category: 'Scams')
  Airtable::Wrapper.find_or_create_card(sheet: 'Safety', category: "Where's my nearest embassy?")

  ## Tech
  Airtable::Wrapper.find_or_create_card(sheet: 'Tech', category: 'Prepaid SIM')

  ## Money
  Airtable::Wrapper.find_or_create_card(sheet: 'Money', category: 'Big Mac Index')
  Airtable::Wrapper.find_or_create_card(sheet: 'Money', category: 'Tipping')

  ## Health
  Airtable::Wrapper.find_or_create_card(sheet: 'Health', category: 'Can you drink the tap water?')
  Airtable::Wrapper.find_or_create_card(sheet: 'Health', category: 'Reputable hospital')
end
