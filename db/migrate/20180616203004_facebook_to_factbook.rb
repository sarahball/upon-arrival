class FacebookToFactbook < ActiveRecord::Migration[5.2]
  def change
    rename_column :destinations, :facebook_path, :factbook_path
  end
end
