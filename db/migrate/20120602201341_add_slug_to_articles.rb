class AddSlugToArticles < ActiveRecord::Migration
  def up
    add_column :article_bases, :slug, :string
    add_column :article_namespaces, :slug, :string

    add_index :article_bases, :slug, :unique => true
    add_index :article_namespaces, :slug, :unique => true
  end

  def down
    remove_index :article_namespaces, :slug
    remove_index :article_bases, :slug

    remove_column :article_namespaces, :slug
    remove_column :article_bases, :slug
  end
end