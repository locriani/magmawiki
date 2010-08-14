class CreateWikiSessions < ActiveRecord::Migration
  def self.up
    create_table :wiki_sessions do |t|
      t.references :user
      t.references :ip_address
      t.references :revision

      t.timestamps
    end
  end

  def self.down
    drop_table :wiki_sessions
  end
end
