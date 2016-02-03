class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :parent
      t.references :section, null: false, foreign_key: true
      t.text :content, null: false
      t.timestamps null: false
    end

    add_foreign_key :proposals, :proposals, column: :parent_id
    add_index :proposals, [:section_id, :parent_id, :user_id]
  end
end
