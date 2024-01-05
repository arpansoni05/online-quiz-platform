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

ActiveRecord::Schema[7.0].define(version: 2023_10_25_164222) do
  create_table "allocations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "assessment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "score"
    t.index ["assessment_id"], name: "index_allocations_on_assessment_id"
    t.index ["user_id"], name: "index_allocations_on_user_id"
  end

  create_table "answers", force: :cascade do |t|
    t.string "content"
    t.boolean "correct", default: false, null: false
    t.integer "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.string "title"
    t.integer "duration_minutes"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_mcqs_questions"
    t.index ["user_id"], name: "index_assessments_on_user_id"
  end

  create_table "coding_questions", force: :cascade do |t|
    t.integer "assessment_id", null: false
    t.string "content"
    t.string "answer"
    t.string "test1"
    t.string "test2"
    t.string "test3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_coding_questions_on_assessment_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.integer "assessment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_options"
    t.index ["assessment_id"], name: "index_questions_on_assessment_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "allocations", "assessments"
  add_foreign_key "allocations", "users"
  add_foreign_key "answers", "questions"
  add_foreign_key "assessments", "users"
  add_foreign_key "coding_questions", "assessments"
  add_foreign_key "questions", "assessments"
end
