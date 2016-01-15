class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.references :user, null: false, foreign_key: true
      t.references :proposal, null: false, foreign_key: true
      t.string :title, null: false
      t.string :content, null: false
      t.timestamps null: false
    end

    add_index :references, [:user_id, :proposal_id], unique: true
  end
end
