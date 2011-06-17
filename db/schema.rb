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

ActiveRecord::Schema.define(:version => 20110310102035) do

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
    t.integer  "wiki_session_id"
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
    t.string   "username"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "wiki_sessions", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
  end

end
