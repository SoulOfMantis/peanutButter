# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_10_23_090913) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "gamejam_participants", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "gamejam_id", null: false
  end

  create_table "gamejams", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "theme", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "Private", null: false
    t.date "start_date"
    t.date "end_date"
    t.bigint "author_id", null: false
    t.index ["author_id"], name: "index_gamejams_on_author_id"
  end

  create_table "jam_submissions", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id", null: false
    t.bigint "gamejam_id", null: false
    t.index ["author_id"], name: "index_jam_submissions_on_author_id"
    t.index ["gamejam_id"], name: "index_jam_submissions_on_gamejam_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "nickname"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "gamejams", "users", column: "author_id"
  add_foreign_key "jam_submissions", "gamejams"
  add_foreign_key "jam_submissions", "users", column: "author_id"
  add_foreign_key "sessions", "users"
end
