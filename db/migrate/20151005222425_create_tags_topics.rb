class CreateTagsTopics < ActiveRecord::Migration
  def change
    create_join_table :tags, :topics do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
    end

    add_index :tags_topics, [:topic_id, :tag_id], unique: true
  end
end
