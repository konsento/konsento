class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :user, index: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :token, null: false
      t.timestamps null: false
    end
  end
end
