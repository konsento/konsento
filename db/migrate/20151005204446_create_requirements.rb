class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.references :join_requirement, null: false, foreign_key: true
      t.references :requirable, polymorphic: true, index: true
    end

    add_index :requirements, [:requirable_id, :requirable_type, :join_requirement_id], unique: true, name: 'requirements_index'
  end
end
