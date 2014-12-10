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

ActiveRecord::Schema.define(version: 20141210143018) do

  create_table "achievements", force: true do |t|
    t.date     "date"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "achievements", ["user_id"], name: "index_achievements_on_user_id", using: :btree

  create_table "blogs", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contest2nds", force: true do |t|
    t.string   "name"
    t.string   "team"
    t.integer  "order"
    t.integer  "a_score"
    t.integer  "a_bp"
    t.integer  "b_score"
    t.integer  "b_bp"
    t.integer  "c_score"
    t.integer  "c_bp"
    t.string   "music"
    t.integer  "notes"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "contest3rds", force: true do |t|
    t.integer  "a_score"
    t.integer  "a_clear"
    t.integer  "b_score"
    t.integer  "b_clear"
    t.integer  "c_score"
    t.integer  "c_clear"
    t.string   "name"
    t.string   "music"
    t.integer  "order"
    t.string   "team"
    t.string   "movie_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "difficulty"
  end

  create_table "contestdate3rds", force: true do |t|
    t.integer  "order"
    t.string   "place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contestdates", force: true do |t|
    t.integer  "order"
    t.string   "place"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "menu_id"
    t.text     "content"
    t.integer  "entry_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["updated_at"], name: "index_entries_on_updated_at", using: :btree
  add_index "entries", ["url"], name: "index_entries_on_url", using: :btree

  create_table "master_games", force: true do |t|
    t.string   "title"
    t.string   "voter"
    t.string   "top"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "master_musics", force: true do |t|
    t.string   "title"
    t.integer  "game"
    t.string   "voter"
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "author"
    t.string   "url"
  end

  create_table "master_scores", force: true do |t|
    t.string   "account"
    t.integer  "game"
    t.float    "score",          limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "url"
    t.float    "standard_score", limit: 24
    t.integer  "user_id"
  end

  create_table "master_users", force: true do |t|
    t.string   "name"
    t.string   "account"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "menus", force: true do |t|
    t.string   "title"
    t.string   "section"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["section"], name: "index_menus_on_section", using: :btree

  create_table "twitter_accounts", force: true do |t|
    t.decimal  "uid",         precision: 10, scale: 0
    t.string   "screen_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "twitter_accounts", ["user_id"], name: "index_twitter_accounts_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "name"
    t.integer  "year"
    t.integer  "repeated_year"
    t.integer  "grade"
    t.text     "bio"
    t.text     "profile"
    t.string   "profile_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
