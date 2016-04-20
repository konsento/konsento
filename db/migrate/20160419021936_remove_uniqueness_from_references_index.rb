class RemoveUniquenessFromReferencesIndex < ActiveRecord::Migration
  def change
    remove_index :references, [:user_id, :proposal_id]
    add_index :references, [:user_id, :proposal_id], unique: false
  end
end
