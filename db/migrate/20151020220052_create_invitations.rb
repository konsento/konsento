class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email, null: false, index: {unique: true}
      t.string :token, null: false, index: {unique: true}
      t.boolean :registered, default: false
      t.timestamps null: false
    end
  end
end
