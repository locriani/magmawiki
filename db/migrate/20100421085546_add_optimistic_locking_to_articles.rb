class AddOptimisticLockingToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :lock_version, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :articles, :lock_version
  end
end
