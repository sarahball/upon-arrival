class AddWeatherOptionToDestinations < ActiveRecord::Migration[5.2]
  def change
    add_column :destinations, :show_weather, :boolean, default: true
  end
end
