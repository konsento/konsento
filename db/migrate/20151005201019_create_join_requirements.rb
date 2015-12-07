class CreateJoinRequirements < ActiveRecord::Migration
  def change
    create_table :join_requirements do |t|
      t.string :title
      t.timestamps null: false
    end
  end
end
