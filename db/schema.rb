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

ActiveRecord::Schema.define(version: 20171104135125) do

  create_table "charges", force: :cascade do |t|
    t.integer  "staff_id"
    t.integer  "subject_id"
    t.integer  "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "charges", ["staff_id"], name: "index_charges_on_staff_id"
  add_index "charges", ["subject_id"], name: "index_charges_on_subject_id"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recruitments", force: :cascade do |t|
    t.integer  "staff_id"
    t.integer  "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "recruitments", ["staff_id"], name: "index_recruitments_on_staff_id"
  add_index "recruitments", ["subject_id"], name: "index_recruitments_on_subject_id"

  create_table "staffs", force: :cascade do |t|
    t.string   "username"
    t.string   "lastname"
    t.string   "firstname"
    t.string   "kana"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "staffs", ["course_id"], name: "index_staffs_on_course_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "syllabuses", force: :cascade do |t|
    t.integer  "staff_id"
    t.integer  "subject_id"
    t.text     "subtitle"
    t.text     "goal"
    t.text     "abstract"
    t.text     "plan"
    t.text     "evaluationmethod"
    t.text     "textbook"
    t.text     "referencebook"
    t.text     "selectionmethod"
    t.text     "remarks"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "syllabuses", ["staff_id"], name: "index_syllabuses_on_staff_id"
  add_index "syllabuses", ["subject_id"], name: "index_syllabuses_on_subject_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
