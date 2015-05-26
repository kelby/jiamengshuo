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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150526190728) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "applies", force: :cascade do |t|
    t.integer  "status",     limit: 4,   default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id",    limit: 4
    t.integer  "mentor_id",  limit: 4
    t.string   "info",       limit: 255
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "provider",     limit: 255
    t.string   "uid",          limit: 255
    t.integer  "user_id",      limit: 4
    t.string   "access_token", limit: 255
    t.datetime "expires_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "catalogs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "parent_id",  limit: 4
    t.string   "info",       limit: 255
    t.string   "icon",       limit: 255
    t.integer  "icon_from",  limit: 4
    t.datetime "deleted_at"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content",          limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id",          limit: 4
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.datetime "deleted_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "direct_messages", force: :cascade do |t|
    t.text     "content",      limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "from_user_id", limit: 4
    t.integer  "to_user_id",   limit: 4
    t.boolean  "read",         limit: 1,     default: false
  end

  add_index "direct_messages", ["from_user_id"], name: "index_direct_messages_on_from_user_id", using: :btree
  add_index "direct_messages", ["to_user_id"], name: "index_direct_messages_on_to_user_id", using: :btree

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",   limit: 4,                   null: false
    t.string   "followable_type", limit: 255,                 null: false
    t.integer  "follower_id",     limit: 4,                   null: false
    t.string   "follower_type",   limit: 255,                 null: false
    t.boolean  "blocked",         limit: 1,   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "liker_comments", force: :cascade do |t|
    t.integer  "liker_id",   limit: 4
    t.integer  "comment_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "liker_comments", ["liker_id"], name: "index_liker_comments_on_liker_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
    t.string   "icon",        limit: 255
    t.integer  "icon_from",   limit: 4
  end

  create_table "replies", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id",    limit: 4
    t.integer  "comment_id", limit: 4
  end

  add_index "replies", ["comment_id"], name: "index_replies_on_comment_id", using: :btree
  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.string   "heading",     limit: 255
    t.text     "body",        limit: 65535
    t.integer  "position",    limit: 4
    t.integer  "post_id",     limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "description", limit: 65535
    t.integer  "user_id",     limit: 4
    t.integer  "subject_id",  limit: 4
    t.integer  "head",        limit: 4,     default: 2
  end

  add_index "sections", ["post_id"], name: "index_sections_on_post_id", using: :btree
  add_index "sections", ["subject_id"], name: "index_sections_on_subject_id", using: :btree
  add_index "sections", ["user_id"], name: "index_sections_on_user_id", using: :btree

  create_table "snippets", force: :cascade do |t|
    t.text     "body",       limit: 65535
    t.integer  "topic_id",   limit: 4
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.string   "spec",       limit: 255
    t.string   "color",      limit: 255
    t.decimal  "per_price",                precision: 10
    t.integer  "quantity",   limit: 4
    t.string   "address",    limit: 255
    t.string   "website",    limit: 255
    t.integer  "status",     limit: 4,                    default: 0
  end

  add_index "snippets", ["topic_id"], name: "index_snippets_on_topic_id", using: :btree
  add_index "snippets", ["user_id"], name: "index_snippets_on_user_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id",    limit: 4
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "topic_and_users", force: :cascade do |t|
    t.integer  "topic_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "type",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "topic_and_users", ["topic_id"], name: "index_topic_and_users_on_topic_id", using: :btree
  add_index "topic_and_users", ["user_id"], name: "index_topic_and_users_on_user_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "body",           limit: 65535
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "user_id",        limit: 4
    t.boolean  "essence",        limit: 1,     default: false
    t.integer  "catalog_id",     limit: 4,     default: 1003
    t.integer  "category",       limit: 4
    t.integer  "mode",           limit: 4
    t.integer  "invoice",        limit: 4
    t.date     "deadline"
    t.integer  "rate",           limit: 4
    t.integer  "freight_source", limit: 4
    t.string   "barcode",        limit: 255,                   null: false
    t.integer  "status",         limit: 4,     default: 0
    t.string   "website",        limit: 255
    t.string   "from_address",   limit: 255
    t.string   "to_address",     limit: 255
    t.datetime "deleted_at"
  end

  add_index "topics", ["catalog_id"], name: "index_topics_on_catalog_id", using: :btree
  add_index "topics", ["title"], name: "index_topics_on_title", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "user_bodies", force: :cascade do |t|
    t.integer  "gender",     limit: 4,   default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.datetime "birth_date"
    t.string   "website",    limit: 255
    t.string   "phone",      limit: 255
    t.string   "weibo",      limit: 255
    t.string   "qq",         limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "location",   limit: 255
  end

  add_index "user_bodies", ["user_id"], name: "index_user_bodies_on_user_id", using: :btree

  create_table "user_relationships", force: :cascade do |t|
    t.integer  "owner_id",     limit: 4
    t.integer  "recipient_id", limit: 4
    t.string   "type",         limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "user_relationships", ["owner_id"], name: "index_user_relationships_on_owner_id", using: :btree
  add_index "user_relationships", ["recipient_id"], name: "index_user_relationships_on_recipient_id", using: :btree

  create_table "user_wishes", force: :cascade do |t|
    t.integer  "wish_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_wishes", ["user_id"], name: "index_user_wishes_on_user_id", using: :btree
  add_index "user_wishes", ["wish_id"], name: "index_user_wishes_on_wish_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: ""
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               limit: 255
    t.string   "avatar",                 limit: 255
    t.string   "info",                   limit: 255
    t.boolean  "faker",                  limit: 1,   default: false
    t.integer  "posts_count",            limit: 4,   default: 0
    t.datetime "deleted_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "wishes", force: :cascade do |t|
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  add_index "wishes", ["user_id"], name: "index_wishes_on_user_id", using: :btree

end
