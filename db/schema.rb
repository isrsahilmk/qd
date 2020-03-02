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

ActiveRecord::Schema.define(version: 2020_02_26_200529) do

  create_table "answers", force: :cascade do |t|
    t.text "short_answer"
    t.text "descriptive_answer"
    t.string "lab_id"
    t.string "name"
    t.integer "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "title"
    t.text "body"
    t.string "lab_id"
    t.string "name"
    t.string "branch"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "view_count", default: 0
    t.integer "student_year"
  end

  create_table "student_lab_ids", force: :cascade do |t|
    t.string "lab_id"
    t.string "name"
    t.string "branch"
    t.boolean "taken", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "student_records", force: :cascade do |t|
    t.string "lab_id"
    t.string "name"
    t.string "branch"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "year"
  end

  create_table "teacher_lab_ids", force: :cascade do |t|
    t.string "lab_id"
    t.string "name"
    t.string "branch"
    t.boolean "taken", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teacher_notifications", force: :cascade do |t|
    t.text "body"
    t.boolean "read", default: false
    t.integer "teacher_record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["teacher_record_id"], name: "index_teacher_notifications_on_teacher_record_id"
  end

  create_table "teacher_records", force: :cascade do |t|
    t.string "lab_id"
    t.string "name"
    t.string "branch"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "teacher_notifications", "teacher_records"
end
