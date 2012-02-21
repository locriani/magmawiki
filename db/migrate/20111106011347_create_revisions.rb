class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.integer :article_id
      t.text :body
      t.string :engine
      t.boolean :compressed
      t.integer :editor_id
      t.text :edit_summary
      t.text :auto_summary

      t.timestamps
    end
    add_index :revisions, [:article_id, :id], :unique => true
    add_index :revisions, :article_id
  end
end