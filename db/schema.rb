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

ActiveRecord::Schema.define(:version => 20120602184919) do

  create_table "article_bases", :force => true do |t|
    t.string   "title"
    t.integer  "current_revision_id"
    t.integer  "view_count"
    t.integer  "edit_count"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "article_bases", ["title"], :name => "index_article_bases_on_title", :unique => true

  create_table "article_namespaces", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "article_namespaces", ["name"], :name => "index_article_namespaces_on_name", :unique => true

  create_table "article_revisions", :force => true do |t|
    t.integer  "base_id"
    t.text     "body"
    t.string   "engine"
    t.boolean  "compressed"
    t.integer  "editor_id"
    t.text     "edit_summary"
    t.text     "auto_summary"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "article_revisions", ["base_id", "id"], :name => "index_article_revisions_on_base_id_and_id", :unique => true
  add_index "article_revisions", ["base_id"], :name => "index_article_revisions_on_base_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "admin_users"
    t.boolean  "moderate_users"
    t.boolean  "admin_permissions"
    t.boolean  "admin_namespaces"
    t.integer  "global_permission_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "groups", ["global_permission_id"], :name => "index_groups_on_global_permission_id"

  create_table "permissions", :force => true do |t|
    t.integer  "namespace_id"
    t.integer  "group_id"
    t.boolean  "create"
    t.boolean  "read"
    t.boolean  "update"
    t.boolean  "destroy"
    t.boolean  "move"
    t.boolean  "restrict"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "permissions", ["group_id"], :name => "index_permissions_on_group_id"
  add_index "permissions", ["namespace_id", "group_id"], :name => "index_permissions_on_namespace_id_and_group_id"
  add_index "permissions", ["namespace_id"], :name => "index_permissions_on_namespace_id"

  create_table "restrictions", :force => true do |t|
    t.integer  "article_id"
    t.integer  "revision_id"
    t.integer  "creator_id"
    t.datetime "effective_at"
    t.datetime "expires_at"
    t.integer  "restricted_group_id"
    t.string   "restriction_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "restrictions", ["article_id", "restricted_group_id"], :name => "index_restrictions_on_article_id_and_restricted_group_id"
  add_index "restrictions", ["article_id"], :name => "index_restrictions_on_article_id"
  add_index "restrictions", ["creator_id"], :name => "index_restrictions_on_creator_id"
  add_index "restrictions", ["restricted_group_id"], :name => "index_restrictions_on_restricted_group_id"
  add_index "restrictions", ["revision_id"], :name => "index_restrictions_on_revision_id"

end
