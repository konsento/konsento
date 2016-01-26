class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :title, null: false
      t.boolean :public, default: false
    end
  end
end
