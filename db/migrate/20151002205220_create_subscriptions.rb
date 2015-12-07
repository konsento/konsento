class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :role
      t.timestamps null: false
    end
    add_index :subscriptions, [:user_id, :group_id], unique: true
  end
end
