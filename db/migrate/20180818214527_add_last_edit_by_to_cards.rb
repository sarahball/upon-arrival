class AddLastEditByToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :last_edit_by_user_id, :bigint
  end
end
