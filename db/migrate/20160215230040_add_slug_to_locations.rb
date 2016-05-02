class AddSlugToLocations < ActiveRecord::Migration
  def up
    add_column :locations, :slug, :string
    add_index :locations, [:slug, :parent_id], unique: true
    Location.find_each(&:save)
    change_column :locations, :slug, :string, null: false
  end

  def down
    remove_column :locations, :slug
  end
end
