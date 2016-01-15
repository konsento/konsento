class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :proposal, null:false, foreign_key: true
      t.integer :opinion, null: false
      t.timestamps null: false
    end

    add_index :votes, [:user_id, :proposal_id], unique: true
  end
end
