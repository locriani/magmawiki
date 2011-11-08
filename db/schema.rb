# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111106011347) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.integer  "current_revision_id"
    t.integer  "view_count"
    t.integer  "edit_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["title"], :name => "index_articles_on_title", :unique => true

  create_table "revisions", :force => true do |t|
    t.integer  "article_id"
    t.text     "body"
    t.string   "engine"
    t.boolean  "compressed"
    t.integer  "editor_id"
    t.text     "edit_summary"
    t.text     "auto_summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "revisions", ["article_id", "id"], :name => "index_revisions_on_article_id_and_id", :unique => true
  add_index "revisions", ["article_id"], :name => "index_revisions_on_article_id"

end
