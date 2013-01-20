class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.references :namespace

      t.timestamps
    end
    add_index :articles, :namespace_id
  end
end
