class CreateUserPreferences < ActiveRecord::Migration
  def self.up
    create_table :user_preferences do |t|
      t.string :preference
      t.string :value
      t.integer :user_id

      t.timestamps
    end
    add_index :user_preferences, [:user_id, :preference], :unique => true
    add_index :user_preferences, :user_id
    add_index :user_preferences, :value
  end

  def self.down
    remove_index :user_preferences, :value
    remove_index :user_preferences, :user_id
    remove_index :user_preferences, :column => [:user_id, :preference]
    drop_table :user_preferences
  end
end
