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

ActiveRecord::Schema.define(version: 2021_10_23_063033) do

  create_table "enquetes", force: :cascade do |t|
    t.integer "team_id", null: false
    t.string "title", null: false
    t.date "deadline", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_enquetes_on_team_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", default: "", null: false
    t.integer "emp_no"
    t.string "grade"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "replies", force: :cascade do |t|
    t.integer "enquete_id", null: false
    t.integer "user_id", null: false
    t.string "this_grade"
    t.string "this_status"
    t.text "pj_technical_skill"
    t.text "pj_relationships"
    t.text "pj_appeal_problem"
    t.string "future_job_category"
    t.string "future_grade_1y"
    t.text "future_image_1y"
    t.text "future_action_1y"
    t.string "future_grade_3y"
    t.text "future_image_3y"
    t.text "future_action_3y"
    t.string "future_grade_5y"
    t.text "future_image_5y"
    t.text "future_action_5y"
    t.string "this_target1"
    t.integer "this_target1_achv"
    t.text "this_target1_remarks"
    t.string "this_target2"
    t.integer "this_target2_achv"
    t.text "this_target2_remarks"
    t.string "next_target1"
    t.integer "next_target1_ratio"
    t.string "next_target2"
    t.integer "next_target2_ratio"
    t.text "seminor_contents"
    t.integer "course_hour"
    t.text "eval_knowledge"
    t.text "eval_customer"
    t.text "eval_contribution"
    t.text "eval_quantity_quality"
    t.text "eval_posivity"
    t.text "eval_decipline"
    t.text "eval_responsibility"
    t.text "req_manager"
    t.text "req_sales"
    t.text "req_admin"
    t.text "req_company"
    t.integer "update_count", default: 0, null: false
    t.datetime "submitted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enquete_id"], name: "index_replies_on_enquete_id"
    t.index ["user_id"], name: "index_replies_on_user_id"
  end

  create_table "team_users", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_team_users_on_team_id"
    t.index ["user_id"], name: "index_team_users_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "manager_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["manager_id"], name: "index_teams_on_manager_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "enquetes", "teams"
  add_foreign_key "profiles", "users"
  add_foreign_key "replies", "enquetes"
  add_foreign_key "replies", "users"
  add_foreign_key "team_users", "teams"
  add_foreign_key "team_users", "users"
  add_foreign_key "teams", "users", column: "manager_id"
end
