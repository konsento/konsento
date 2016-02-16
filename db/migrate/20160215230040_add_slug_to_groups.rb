class AddSlugToGroups < ActiveRecord::Migration
  def up
    add_column :groups, :slug, :string
    add_index :groups, [:slug, :parent_id], unique: true
    Group.find_each(&:save)
    change_column :groups, :slug, :string, null: false
  end

  def down
    drop_column :groups, :slug
  end
end
