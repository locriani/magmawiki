class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.integer :current_revision_id
      t.integer :view_count
      t.integer :edit_count

      t.timestamps
    end
  end
end
