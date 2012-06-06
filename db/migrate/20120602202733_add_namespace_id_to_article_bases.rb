class AddNamespaceIdToArticleBases < ActiveRecord::Migration
  def change
    add_column :article_bases, :namespace_id, :integer
  end
end
