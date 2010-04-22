class AddCounterCacheToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :revision_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :articles, :revision_count
  end
end
