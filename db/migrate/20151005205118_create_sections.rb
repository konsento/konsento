class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :topic, foreign_key: true, null: false
      t.integer :index

      t.timestamps null: false
    end

    add_index :sections, [:topic_id, :index], unique: true
  end
end
