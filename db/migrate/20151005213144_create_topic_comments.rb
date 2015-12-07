class CreateTopicComments < ActiveRecord::Migration
  def change
    create_table :topic_comments do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.timestamps null: false
    end
    add_index :topic_comments, [:topic_id, :comment_id], unique: true
  end
end
