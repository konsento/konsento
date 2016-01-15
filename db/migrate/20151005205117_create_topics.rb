class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :user, null: false, foreign_key: true
      t.references :parent, index: true
      t.references :group, null:false, foreign_key: true
      t.string :title, null: false
      t.timestamps null: false
    end

    add_foreign_key :topics, :topics, column: :parent_id
    add_index :topics, [:user_id, :parent_id, :group_id], unique: true
  end
end
