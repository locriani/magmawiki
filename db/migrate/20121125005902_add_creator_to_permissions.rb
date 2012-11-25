class AddCreatorToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :creator_id, :int
    add_index :permissions, :creator_id
  end
end
