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

ActiveRecord::Schema.define(version: 2020_10_13_121901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "football_reviews", force: :cascade do |t|
    t.text "content"
    t.integer "rating"
    t.bigint "user_id", null: false
    t.bigint "football_score_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["football_score_id"], name: "index_football_reviews_on_football_score_id"
    t.index ["user_id"], name: "index_football_reviews_on_user_id"
  end

  create_table "football_scores", force: :cascade do |t|
    t.string "home_team_name"
    t.string "away_team_name"
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.integer "home_team_fulltime_score"
    t.integer "away_team_fulltime_score"
    t.integer "match_id"
    t.integer "competition_id"
    t.string "competition_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["match_id"], name: "index_football_scores_on_match_id", unique: true
  end

  create_table "football_teams", force: :cascade do |t|
    t.string "name"
    t.integer "team_api_id"
    t.string "short_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "team_country"
    t.index ["team_api_id"], name: "index_football_teams_on_team_api_id", unique: true
  end

  create_table "user_football_teams", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "football_team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["football_team_id"], name: "index_user_football_teams_on_football_team_id"
    t.index ["user_id"], name: "index_user_football_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "football_reviews", "football_scores"
  add_foreign_key "football_reviews", "users"
  add_foreign_key "user_football_teams", "football_teams"
  add_foreign_key "user_football_teams", "users"
end
