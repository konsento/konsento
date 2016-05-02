class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :parent, index: true
      t.string :title, null: false
      t.text :description
      t.float :total_votes_percent, null: false
      t.float :agree_votes_percent, null: false
      t.timestamps null: false
    end

    add_foreign_key :locations, :locations, column: :parent_id
  end
end
