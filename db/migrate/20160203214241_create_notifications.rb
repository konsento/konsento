class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :key, null: false
      t.json :data, null: false
      t.references :notifiable, polymorphic: true, index: true
      t.boolean :read, default: false
    end
  end
end
