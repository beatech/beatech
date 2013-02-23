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

ActiveRecord::Schema.define(:version => 20130223135109) do

  create_table "contest2nds", :force => true do |t|
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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contestdates", :force => true do |t|
    t.integer  "order"
    t.string   "place"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "master_games", :force => true do |t|
    t.string   "title"
    t.string   "voter"
    t.string   "top"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "master_musics", :force => true do |t|
    t.string   "title"
    t.integer  "game"
    t.string   "voter"
    t.integer  "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "author"
    t.string   "url"
  end

  create_table "master_scores", :force => true do |t|
    t.string   "account"
    t.integer  "game"
    t.integer  "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "master_users", :force => true do |t|
    t.string   "name"
    t.string   "account"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "menu"
    t.integer  "limit"
    t.text     "text",       :limit => 16777215
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "account"
    t.string   "name"
    t.string   "password_digest"
    t.integer  "uid"
    t.integer  "year"
    t.integer  "state"
    t.string   "profile"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
