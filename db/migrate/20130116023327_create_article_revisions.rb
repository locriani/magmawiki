class CreateArticleRevisions < ActiveRecord::Migration
  def change
    create_table :article_revisions do |t|
      t.references :article
      t.text :body
      t.string :engine
      t.boolean :compressed
      t.references :editor
      t.string :edit_summary

      t.timestamps
    end
    add_index :article_revisions, :article_id
    add_index :article_revisions, :editor_id
  end
end
