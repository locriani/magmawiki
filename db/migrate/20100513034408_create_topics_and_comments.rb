class CreateTopicsAndComments < ActiveRecord::Migration

  def self.up

    create_table :topics do |t|
      t.integer :article_id
      t.integer :revision_id

      t.integer :user_id
      t.string  :subject

      t.string  :type
      t.string  :status

      # inline comment information
      t.string  :tagged_text
      t.integer :tag_start
      t.integer :tag_end

      t.timestamps
    end

    add_index :topics, :article_id
    add_index :topics, :revision_id
    add_index :topics, :type
    add_index :topics, :status
    

    create_table :comments do |t|
      t.integer :user_id
      t.integer :topic_id
      
      t.string  :subject
      t.text    :body

      # nested set
      t.integer :parent_id
      t.integer :left
      t.integer :right

      t.timestamps
    end

    add_index :comments, :topic_id
    add_index :comments, :user_id
    add_index :comments, :parent_id
    add_index :comments, :left
    add_index :comments, :right
  end


  def self.down
    drop_table :topics
    drop_table :comments
  end

end
