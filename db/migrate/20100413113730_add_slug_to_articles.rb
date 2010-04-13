class AddSlugToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :slug, :string
  end

  def self.down
    remove_column :articles, :slug
  end
end
