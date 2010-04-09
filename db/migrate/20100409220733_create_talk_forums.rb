class CreateTalkForums < ActiveRecord::Migration
  def self.up
    create_table :talk_forums do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :talk_forums
  end
end
