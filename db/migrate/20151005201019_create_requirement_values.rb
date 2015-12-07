class CreateRequirementValues < ActiveRecord::Migration
  def change
    create_table :requirement_values do |t|
      t.references :user, null:false, foreign_key: true
      t.references :join_requirement, null: false, foreign_key: true
      t.string :value, null: false
      t.timestamps null: false
    end
    add_index :requirement_values, [:user_id, :join_requirement_id], unique: true
  end
end
