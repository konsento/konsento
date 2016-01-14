class CreateGroupsJoinRequirements < ActiveRecord::Migration
  def change
    create_join_table :groups, :join_requirements do |t|
      t.references :group, null: false, foreign_key: true
      t.references :join_requirement, null: false, foreign_key: true
    end

    add_index :groups_join_requirements, [:group_id, :join_requirement_id], unique: true, name: 'groups_join_requirements_index'
  end
end
