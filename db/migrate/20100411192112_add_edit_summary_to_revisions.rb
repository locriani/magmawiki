class AddEditSummaryToRevisions < ActiveRecord::Migration
  def self.up
    add_column :revisions, :summary, :string
  end

  def self.down
    remove_column :revisions, :summary
  end
end
