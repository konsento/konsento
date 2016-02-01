class CreateTeamInvitations < ActiveRecord::Migration
  def change
    create_table :team_invitations do |t|
      t.references :team, null: false
      t.string :email, null: false
      t.string :token, null: false, index: {unique: true}
      t.boolean :accepted, default: false
      t.timestamps null: false
    end
  end
end
