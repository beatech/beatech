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

ActiveRecord::Schema.define(version: 20161008093702) do

  create_table "achievements", force: :cascade do |t|
    t.date     "date"
    t.text     "text",              limit: 65535
    t.integer  "user_id",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_status_id", limit: 255
  end

  add_index "achievements", ["user_id"], name: "index_achievements_on_user_id", using: :btree

  create_table "blogs", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "blog_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contest2nds", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "team",       limit: 255
    t.integer  "order",      limit: 4
    t.integer  "a_score",    limit: 4
    t.integer  "a_bp",       limit: 4
    t.integer  "b_score",    limit: 4
    t.integer  "b_bp",       limit: 4
    t.integer  "c_score",    limit: 4
    t.integer  "c_bp",       limit: 4
    t.string   "music",      limit: 255
    t.integer  "notes",      limit: 4
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  create_table "contest3rds", force: :cascade do |t|
    t.integer  "a_score",    limit: 4
    t.integer  "a_clear",    limit: 4
    t.integer  "b_score",    limit: 4
    t.integer  "b_clear",    limit: 4
    t.integer  "c_score",    limit: 4
    t.integer  "c_clear",    limit: 4
    t.string   "name",       limit: 255
    t.string   "music",      limit: 255
    t.integer  "order",      limit: 4
    t.string   "team",       limit: 255
    t.string   "movie_url",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "difficulty", limit: 4
  end

  add_index "contest3rds", ["team"], name: "index_contest3rds_on_team", using: :btree

  create_table "contestdate3rds", force: :cascade do |t|
    t.integer  "order",      limit: 4
    t.string   "place",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contestdates", force: :cascade do |t|
    t.integer  "order",      limit: 4
    t.string   "place",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "entries", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.integer  "menu_id",    limit: 4
    t.text     "content",    limit: 65535
    t.integer  "entry_type", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["menu_id"], name: "index_entries_on_menu_id", using: :btree
  add_index "entries", ["updated_at"], name: "index_entries_on_updated_at", using: :btree
  add_index "entries", ["url"], name: "index_entries_on_url", using: :btree

  create_table "master_games", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "voter",      limit: 255
    t.string   "top",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "master_musics", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "game",       limit: 4
    t.string   "voter",      limit: 255
    t.integer  "number",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "author",     limit: 255
    t.string   "url",        limit: 255
  end

  create_table "master_scores", force: :cascade do |t|
    t.string   "account",        limit: 255
    t.integer  "game",           limit: 4
    t.float    "score",          limit: 24
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "url",            limit: 255
    t.float    "standard_score", limit: 24
    t.integer  "user_id",        limit: 4
  end

  create_table "master_users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "account",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  create_table "menus", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "section",    limit: 255
    t.integer  "position",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["section"], name: "index_menus_on_section", using: :btree

  create_table "twitter_accounts", force: :cascade do |t|
    t.string   "uid",         limit: 255
    t.string   "screen_name", limit: 255
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "twitter_accounts", ["user_id"], name: "index_twitter_accounts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "password_digest", limit: 255
    t.string   "name",            limit: 255
    t.integer  "year",            limit: 4
    t.integer  "repeated_year",   limit: 4
    t.integer  "grade",           limit: 4
    t.text     "bio",             limit: 65535
    t.text     "profile",         limit: 65535
    t.string   "profile_image",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["updated_at"], name: "index_users_on_updated_at", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
