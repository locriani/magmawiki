class CreateNamespaces < ActiveRecord::Migration
  def change
    create_table :namespaces do |t|
      t.string :name

      t.timestamps
    end
    
    add_index :namespaces, :name
  end
end
