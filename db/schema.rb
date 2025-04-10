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

ActiveRecord::Schema[8.0].define(version: 2024_06_06_015135) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "solution_step_id", null: false
    t.bigint "user_id", null: false
    t.bigint "team_id"
    t.string "response", null: false
    t.boolean "correct", default: false, null: false
    t.integer "attempt_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solution_step_id"], name: "index_answers_on_solution_step_id"
    t.index ["team_id"], name: "index_answers_on_team_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "public", default: true, null: false
    t.integer "position", default: 1
    t.bigint "lo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "solution_steps_count"
    t.index ["lo_id"], name: "index_exercises_on_lo_id"
    t.index ["title"], name: "index_exercises_on_title", unique: true
  end

  create_table "exercises_visualizations", force: :cascade do |t|
    t.bigint "exercise_id", null: false
    t.bigint "user_id", null: false
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercises_visualizations_on_exercise_id"
    t.index ["team_id"], name: "index_exercises_visualizations_on_team_id"
    t.index ["user_id"], name: "index_exercises_visualizations_on_user_id"
  end

  create_table "introductions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "public", default: true, null: false
    t.integer "position", default: 1
    t.bigint "lo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lo_id"], name: "index_introductions_on_lo_id"
    t.index ["title"], name: "index_introductions_on_title", unique: true
  end

  create_table "introductions_visualizations", force: :cascade do |t|
    t.bigint "introduction_id", null: false
    t.bigint "user_id", null: false
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["introduction_id"], name: "index_introductions_visualizations_on_introduction_id"
    t.index ["team_id"], name: "index_introductions_visualizations_on_team_id"
    t.index ["user_id"], name: "index_introductions_visualizations_on_user_id"
  end

  create_table "los", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "introductions_count"
    t.integer "exercises_count"
    t.bigint "user_id"
    t.index ["title"], name: "index_los_on_title", unique: true
    t.index ["user_id"], name: "index_los_on_user_id"
  end

  create_table "los_teams", id: false, force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "lo_id"
    t.index ["lo_id"], name: "index_los_teams_on_lo_id"
    t.index ["team_id"], name: "index_los_teams_on_team_id"
  end

  create_table "solution_steps", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "response"
    t.integer "decimal_digits"
    t.boolean "public", default: true, null: false
    t.integer "position", default: 1
    t.bigint "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tips_count"
    t.integer "tips_display_mode", default: 0
    t.index ["exercise_id"], name: "index_solution_steps_on_exercise_id"
    t.index ["title"], name: "index_solution_steps_on_title", unique: true
  end

  create_table "solution_steps_visualizations", force: :cascade do |t|
    t.bigint "solution_step_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.index ["solution_step_id"], name: "index_solution_steps_visualizations_on_solution_step_id"
    t.index ["team_id"], name: "index_solution_steps_visualizations_on_team_id"
    t.index ["user_id"], name: "index_solution_steps_visualizations_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["code"], name: "index_teams_on_code", unique: true
    t.index ["name"], name: "index_teams_on_name", unique: true
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "tips", force: :cascade do |t|
    t.text "description"
    t.integer "number_attempts"
    t.integer "position", default: 1
    t.bigint "solution_step_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["solution_step_id"], name: "index_tips_on_solution_step_id"
    t.index ["title"], name: "index_tips_on_title", unique: true
  end

  create_table "tips_visualizations", force: :cascade do |t|
    t.bigint "tip_id", null: false
    t.bigint "user_id", null: false
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_tips_visualizations_on_team_id"
    t.index ["tip_id"], name: "index_tips_visualizations_on_tip_id"
    t.index ["user_id"], name: "index_tips_visualizations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.string "name"
    t.boolean "guest", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_teams", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.index ["team_id"], name: "index_users_teams_on_team_id"
    t.index ["user_id"], name: "index_users_teams_on_user_id"
  end

  add_foreign_key "answers", "solution_steps"
  add_foreign_key "answers", "teams"
  add_foreign_key "answers", "users"
  add_foreign_key "exercises_visualizations", "exercises"
  add_foreign_key "exercises_visualizations", "teams"
  add_foreign_key "exercises_visualizations", "users"
  add_foreign_key "introductions_visualizations", "introductions"
  add_foreign_key "introductions_visualizations", "teams"
  add_foreign_key "introductions_visualizations", "users"
  add_foreign_key "los", "users"
  add_foreign_key "los_teams", "los"
  add_foreign_key "los_teams", "teams"
  add_foreign_key "solution_steps_visualizations", "solution_steps"
  add_foreign_key "solution_steps_visualizations", "teams"
  add_foreign_key "solution_steps_visualizations", "users"
  add_foreign_key "teams", "users"
  add_foreign_key "tips_visualizations", "teams"
  add_foreign_key "tips_visualizations", "tips"
  add_foreign_key "tips_visualizations", "users"
  add_foreign_key "users_teams", "teams"
  add_foreign_key "users_teams", "users"
end
