class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :namespace_id
      t.integer :group_id
      t.boolean :create
      t.boolean :read
      t.boolean :update
      t.boolean :destroy
      t.boolean :move
      t.boolean :restrict

      t.timestamps
    end
    
    add_index :permissions, :namespace_id
    add_index :permissions, :group_id
    add_index :permissions, [:namespace_id, :group_id]
  end
end