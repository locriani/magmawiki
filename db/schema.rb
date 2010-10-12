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

ActiveRecord::Schema.define(:version => 20100712040454) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.integer  "talk_forum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "lock_version",   :default => 0, :null => false
    t.integer  "revision_count", :default => 0, :null => false
  end

  add_index "articles", ["slug"], :name => "index_articles_on_slug", :unique => true

  create_table "comments", :force => true do |t|
    t.integer  "article_id"
    t.integer  "revision_id"
    t.integer  "user_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "marking_id"
  end

  add_index "comments", ["lft"], :name => "index_comments_on_lft"
  add_index "comments", ["parent_id"], :name => "index_comments_on_parent_id"
  add_index "comments", ["rgt"], :name => "index_comments_on_rgt"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "markings", :force => true do |t|
    t.integer "revision_id"
    t.string  "text"
    t.integer "start"
    t.integer "end"
  end

  add_index "markings", ["revision_id"], :name => "index_markings_on_revision_id"

  create_table "revisions", :force => true do |t|
    t.text     "body"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "summary"
    t.string   "engine_name"
    t.boolean  "approved"
  end

  add_index "revisions", ["approved"], :name => "index_revisions_on_approved"
  add_index "revisions", ["article_id"], :name => "index_revisions_on_article_id"
  add_index "revisions", ["article_id"], :name => "index_revisions_on_article_id_and_is_current"

  create_table "talk_forums", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_preferences", :force => true do |t|
    t.string   "preference"
    t.string   "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_preferences", ["user_id", "preference"], :name => "index_user_preferences_on_user_id_and_preference", :unique => true
  add_index "user_preferences", ["user_id"], :name => "index_user_preferences_on_user_id"
  add_index "user_preferences", ["value"], :name => "index_user_preferences_on_value"

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wiki_sessions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ip_address_id"
    t.integer  "revision_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
