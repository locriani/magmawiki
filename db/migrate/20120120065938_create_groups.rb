class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      
      t.boolean :admin_users
      t.boolean :moderate_users
      t.boolean :admin_permissions
      t.boolean :admin_namespaces
      
      t.integer :global_permission_id
      
      t.timestamps
    end
    
    add_index :groups, :global_permission_id
  end
end
