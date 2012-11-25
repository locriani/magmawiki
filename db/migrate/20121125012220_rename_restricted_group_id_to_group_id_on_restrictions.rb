class RenameRestrictedGroupIdToGroupIdOnRestrictions < ActiveRecord::Migration
  def up
    remove_index :restrictions, [:article_id, :restricted_group_id]
    remove_index :restrictions, :restricted_group_id
    rename_column :restrictions, :restricted_group_id, :group_id
    add_index :restrictions, :group_id
    add_index :restrictions, [:group_id, :article_id]
  end

  def down
    remove_index :restrictions, :group_id
    remove_index :restrictions, [:group_id, :article_id]
    rename_column :restrictions, :group_id, :restricted_group_id
    add_index :restrictions, [:article_id, :restricted_group_id]
    add_index :restrictions, :group_id
  end
end