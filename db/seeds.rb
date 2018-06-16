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

  @airtable_client = Airtable::Client.new(ENV['AIRTABLE_API'])

  # Start filling in our DB
  @departures = Hash[@airtable_client.table("appAKFBlzIeNlvnVl", "Departures").all.collect do |departure|
    [departure.id, Departure.find_or_create_by(name: departure.name)]
  end]

  @destinations = Hash[@airtable_client.table("appAKFBlzIeNlvnVl", "Destinations").all.collect do |destination|
    [destination.id, Destination.find_or_create_by(name: departure.name)]
  end]

  @basics = {}
  @airtable_client.table("appAKFBlzIeNlvnVl", "Basics").all.each do |basic|
    basic.destinations.each do |destination|
      @basics[destination] = {}
      if basic.category = 'slug'
        @destinations[destination].slug = basic.data
      elsif basic.category = 'country'
        @destinations[destination].country = basic.data
      elsif basic.category = 'factbook path'
        @destinations[destination].facebook_path = basic.data
      end
    end
  end

  @destinations.collect(&:save)
end
