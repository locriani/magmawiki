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

/computer
/ordinateur => 302 redirect => /fr/ordinateur
/fr/ordinateur
/fr/computer => 302 redirect => /computer

/en => page about en
/en/apple
magmawiki.com
[en].magmawiki.com/whatever

en.magmawiki.com/wiki/shit
en.magmawiki.com/user/briess
en.magmawiki.com/namespaces is why it doesn't work
unless'
  
  we do
en.magmawiki.com/namespace/apple_products/article/iMa