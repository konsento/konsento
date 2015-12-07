class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, null:false, foreign_key: true
      t.references :parent, index: true
      t.text :content, null: false
      t.references :commentable, polymorphic: true, index: true
      t.timestamps null: false
    end
    add_foreign_key :comments, :comments, column: :parent_id
  end
end
