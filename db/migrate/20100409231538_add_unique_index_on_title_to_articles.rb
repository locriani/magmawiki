class AddUniqueIndexOnTitleToArticles < ActiveRecord::Migration
  def self.up
    add_index :articles, :title, :unique => true
  end

  def self.down
    remove_index :articles, :column => :title
  end
end
