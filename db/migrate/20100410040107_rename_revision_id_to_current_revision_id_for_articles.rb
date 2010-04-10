class RenameRevisionIdToCurrentRevisionIdForArticles < ActiveRecord::Migration
  def self.up
    rename_column :articles, :revision_id, :current_revision_id
  end

  def self.down
    rename_column :articles, :current_revision_idr, :revision_id
  end
end
