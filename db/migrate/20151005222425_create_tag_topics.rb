class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps null: false
    end
    add_index :tag_topics, [:topic_id, :tag_id], unique: true
  end
end
