class AddAvailableInvitationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :available_invitations, :integer
  end
end
