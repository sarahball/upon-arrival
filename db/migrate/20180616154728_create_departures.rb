class CreateDepartures < ActiveRecord::Migration[5.2]
  def change
    create_table :departures do |t|
      t.string :name
      t.string :slug
      t.string :country_code
      t.string :airtable_id

      t.timestamps
    end
  end
end
