class CreateRestrictions < ActiveRecord::Migration
  def change
    create_table :restrictions do |t|
      t.integer :article_id
      t.integer :revision_id
      t.integer :creator_id
      t.datetime :effective_at
      t.datetime :expires_at
      t.integer :restricted_group_id
      t.string :restriction_type

      t.timestamps
    end
    
    add_index :restrictions, :article_id
    add_index :restrictions, :revision_id
    add_index :restrictions, :creator_id
    add_index :restrictions, :restricted_group_id
    add_index :restrictions, [:article_id, :restricted_group_id]
  end
end
