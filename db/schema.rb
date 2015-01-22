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

ActiveRecord::Schema.define(version: 20150122173832) do

  create_table "answers", force: true do |t|
    t.string   "option"
    t.integer  "question_id"
    t.boolean  "correct",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_sections", force: true do |t|
    t.integer "product_id", null: false
    t.integer "section_id", null: false
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  add_index "products", ["id"], name: "index_products_on_id"

  create_table "question_tests", force: true do |t|
    t.integer "test_id",     null: false
    t.integer "question_id", null: false
  end

  create_table "questions", force: true do |t|
    t.string   "content"
    t.string   "question_type"
    t.string   "category"
    t.integer  "product_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "section"
  end

  add_index "questions", ["product_id", "created_at"], name: "index_questions_on_product_id_and_created_at"

  create_table "questions_tests", id: false, force: true do |t|
    t.integer "test_id",     null: false
    t.integer "question_id", null: false
  end

  create_table "scores", force: true do |t|
    t.integer  "user_id"
    t.integer  "test_id"
    t.string   "answer_ids"
    t.decimal  "scores",     precision: 16, scale: 2
    t.boolean  "passed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tests", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "category"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "total"
    t.string   "section"
    t.string   "percent"
    t.string   "region"
    t.string   "minimum"
    t.decimal  "time"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.string   "permission"
    t.string   "validate_code"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
