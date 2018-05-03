class AddTwitterFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :description, :text
    add_column :users, :name, :string
    add_column :users, :website_url, :string
    add_column :users, :profile_image_url, :string
    add_column :users, :location, :string
  end
end
