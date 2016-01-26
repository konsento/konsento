class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :role
      t.references :subscriptable, polymorphic: true, index: true
      t.timestamps null: false
    end

    add_index :subscriptions, [:user_id, :subscriptable_id, :subscriptable_type], unique: true, name: 'subscriptions_index'
  end
end
