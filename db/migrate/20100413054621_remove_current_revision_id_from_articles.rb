class RemoveCurrentRevisionIdFromArticles < ActiveRecord::Migration
  def self.up
    remove_column :articles, :current_revision_id
  end

  def self.down
    add_column :articles, :current_revision_id, :integer
  end
end