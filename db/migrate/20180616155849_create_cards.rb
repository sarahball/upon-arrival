class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :category
      t.string :title
      t.references :destination, foreign_key: true
      t.references :departure, foreign_key: true
      t.string :highlight
      t.text :body
      t.integer :position

      t.timestamps
    end
  end
end
