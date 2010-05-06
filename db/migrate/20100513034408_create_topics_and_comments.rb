class CreateTopicsAndComments < ActiveRecord::Migration

  def self.up

    create_table :comments do |t|
      t.integer :article_id
      t.integer :revision_id

      t.integer :user_id
      t.string  :subject
      t.text    :body

      t.timestamps

      # nested set
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      # marking
      t.integer :marking_id
    end

    add_index :comments, :user_id
    add_index :comments, :parent_id
    add_index :comments, :lft
    add_index :comments, :rgt

    create_table :markings do |t|
      t.integer :revision_id
      t.string  :text
      t.integer :start
      t.integer :end
    end
    
    add_index :markings, :revision_id
  end


  def self.down
    drop_table :topics
    drop_table :comments
  end

end
