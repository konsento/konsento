class ActsAsTaggableOnMigration < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, index: {unique: true}
      t.integer :taggings_count, default: 0
    end

    create_table :taggings do |t|
      t.references :tag
      t.references :taggable, polymorphic: true
      t.references :tagger, polymorphic: true
      t.string :context, limit: 128

      t.datetime :created_at
    end

    add_index :taggings, [
      :tag_id, :taggable_id, :taggable_type, :context, :tagger_id, :tagger_type
    ], unique: true, name: 'taggings_idx'

    add_index :taggings, [:taggable_id, :taggable_type, :context]
  end
end
