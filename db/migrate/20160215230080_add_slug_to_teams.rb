class AddSlugToTeams < ActiveRecord::Migration
  def up
    add_column :teams, :slug, :string
    add_index :teams, :slug, unique: true
    Team.find_each(&:save)
    change_column :teams, :slug, :string, null: false
  end

  def down
    remove_column :teams, :slug
  end
end
