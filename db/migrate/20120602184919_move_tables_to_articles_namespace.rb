class MoveTablesToArticlesNamespace < ActiveRecord::Migration
  def up
    remove_index :articles, :title
    rename_table :articles, :article_bases
    add_index :article_bases, :title, :unique => true

    remove_index :revisions, [:article_id, :id]
    remove_index :revisions, :article_id
    rename_table :revisions, :article_revisions
    add_index :article_revisions, [:article_id, :id], :unique => true
    add_index :article_revisions, :article_id

    remove_index :namespaces, :name
    rename_table :namespaces, :article_namespaces
    add_index :article_namespaces, :name, :unique => true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end