class RevisionEngine < ActiveRecord::Migration
  def self.up
    add_column      :revisions, :engine_name, :string

    remove_column   :revisions, :is_current
    add_column      :revisions, :approved, :boolean
    add_index       :revisions, :approved
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
