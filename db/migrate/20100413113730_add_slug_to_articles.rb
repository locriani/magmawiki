class AddSlugToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :slug, :string
    add_index :articles, :slug, :unique => truer
  end

  def self.down
    remove_index :articles, :slug
    remove_column :articles, :slug
  end
end
