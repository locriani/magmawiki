# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100413113730) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.integer  "talk_forum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "articles", ["slug"], :name => "index_articles_on_slug", :unique => true
  add_index "articles", ["title"], :name => "index_articles_on_title", :unique => true

  create_table "revisions", :force => true do |t|
    t.text     "body"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "summary"
    t.boolean  "is_current"
  end

  add_index "revisions", ["article_id", "is_current"], :name => "index_revisions_on_article_id_and_is_current", :unique => true
  add_index "revisions", ["article_id"], :name => "index_revisions_on_article_id"
  add_index "revisions", ["is_current"], :name => "index_revisions_on_is_current"

  create_table "talk_forums", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
