class CreateProposalComments < ActiveRecord::Migration
  def change
    create_table :proposal_comments do |t|
      t.references :proposal, null: false, foreign_key:true
      t.references :comment, null: false, foreign_key:true
      t.timestamps null: false
    end
    add_index :proposal_comments, [:proposal_id, :comment_id], unique: true
  end
end
