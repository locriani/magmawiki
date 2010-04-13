class AddArticleIndiciesToRevisions < ActiveRecord::Migration
  def self.up
    add_column :revisions, :is_current, :boolean
    add_index :revisions, [:article_id, :is_current], :unique => true
    add_index :revisions, :article_id
    add_index :revisions, :is_current
  end

  def self.down
    add_index :revisions, :is_current
    remove_index :revisions, :article_id
    remove_index :revisions, :column => [:article_id, :is_current]
    remove_column :revisions, :is_current
  end
end
