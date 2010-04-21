class DropUniqueIndexOnTitlesForArticles < ActiveRecord::Migration
  def self.up
    remove_index :articles, :column => :title
  end

  def self.down
    add_index :articles, :title, :unique => true
  end
end
