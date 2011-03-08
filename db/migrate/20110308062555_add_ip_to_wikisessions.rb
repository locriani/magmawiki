class AddIpToWikisessions < ActiveRecord::Migration
  def self.up
    change_table :wiki_sessions do |t|
      t.remove :ip_address_id
      t.string :ip_address
    end
  end

  def self.down
    change_table :wiki_sessions do |t|
      t.references :ip_address_id
      t.remove :ip_address
    end
  end
end
