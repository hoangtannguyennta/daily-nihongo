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

ActiveRecord::Schema[8.1].define(version: 2026_06_05_012927) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "kanas", force: :cascade do |t|
    t.string "character"
    t.datetime "created_at", null: false
    t.string "kind"
    t.string "romaji"
    t.datetime "updated_at", null: false
  end

  create_table "kanjis", force: :cascade do |t|
    t.string "character"
    t.datetime "created_at", null: false
    t.string "jlpt_level"
    t.string "kunyomi"
    t.string "meaning"
    t.string "onyomi"
    t.integer "stroke_count"
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "number"
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "test_answers", force: :cascade do |t|
    t.boolean "correct"
    t.string "correct_answer"
    t.datetime "created_at", null: false
    t.string "selected_answer"
    t.integer "test_attempt_id", null: false
    t.datetime "updated_at", null: false
    t.integer "vocabulary_id", null: false
    t.index ["test_attempt_id"], name: "index_test_answers_on_test_attempt_id"
    t.index ["vocabulary_id"], name: "index_test_answers_on_vocabulary_id"
  end

  create_table "test_attempts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "lesson_id", null: false
    t.integer "score"
    t.integer "total_questions"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["lesson_id"], name: "index_test_attempts_on_lesson_id"
    t.index ["user_id"], name: "index_test_attempts_on_user_id"
  end

  create_table "user_vocabularies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "vocabulary_id", null: false
    t.index ["user_id"], name: "index_user_vocabularies_on_user_id"
    t.index ["vocabulary_id"], name: "index_user_vocabularies_on_vocabulary_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.string "otp_code"
    t.boolean "otp_verified"
    t.string "password_digest"
    t.string "role", default: "user", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "username"
    t.string "verification_token"
    t.boolean "verified"
  end

  create_table "vocabularies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "kana"
    t.integer "lesson_id", null: false
    t.string "meaning"
    t.integer "priority"
    t.string "romaji"
    t.string "type"
    t.datetime "updated_at", null: false
    t.string "word"
    t.index ["lesson_id"], name: "index_vocabularies_on_lesson_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "test_answers", "test_attempts"
  add_foreign_key "test_answers", "vocabularies"
  add_foreign_key "test_attempts", "lessons"
  add_foreign_key "test_attempts", "users"
  add_foreign_key "user_vocabularies", "users"
  add_foreign_key "user_vocabularies", "vocabularies"
  add_foreign_key "vocabularies", "lessons"
end
