# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_14_140513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instrumental_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "instrumental_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["instrumental_id"], name: "index_instrumental_likes_on_instrumental_id"
    t.index ["user_id", "instrumental_id"], name: "index_instrumental_likes_on_user_id_and_instrumental_id", unique: true
    t.index ["user_id"], name: "index_instrumental_likes_on_user_id"
  end

  create_table "instrumentals", force: :cascade do |t|
    t.string "title"
    t.string "track"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_instrumentals_on_title", unique: true
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "auth_provider"
    t.string "auth_uid"
    t.string "image_url"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "instrumental_likes", "instrumentals"
  add_foreign_key "instrumental_likes", "users"
end
