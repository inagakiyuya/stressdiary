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

ActiveRecord::Schema[7.0].define(version: 2023_08_16_164256) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "mean_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mean_id"], name: "index_bookmarks_on_mean_id"
    t.index ["user_id", "mean_id"], name: "index_bookmarks_on_user_id_and_mean_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "diaries", force: :cascade do |t|
    t.string "title"
    t.text "stress"
    t.text "happy"
    t.text "goal"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "diary_comments", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_diary_comments_on_diary_id"
    t.index ["user_id"], name: "index_diary_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_favorites_on_diary_id"
    t.index ["user_id", "diary_id"], name: "index_favorites_on_user_id_and_diary_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "happy_diagnoses", force: :cascade do |t|
    t.integer "happy_count"
    t.bigint "diary_id", null: false
    t.boolean "question1"
    t.boolean "question2"
    t.boolean "question3"
    t.boolean "question4"
    t.boolean "question5"
    t.boolean "question6"
    t.boolean "question7"
    t.boolean "question8"
    t.boolean "question9"
    t.boolean "question10"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_happy_diagnoses_on_diary_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "mean_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mean_id"], name: "index_likes_on_mean_id"
    t.index ["user_id", "mean_id"], name: "index_likes_on_user_id_and_mean_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "mean_comments", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "mean_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mean_id"], name: "index_mean_comments_on_mean_id"
    t.index ["user_id"], name: "index_mean_comments_on_user_id"
  end

  create_table "means", force: :cascade do |t|
    t.string "title"
    t.text "situation"
    t.text "approach"
    t.text "result"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.index ["user_id"], name: "index_means_on_user_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.datetime "remind_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.text "reason", null: false
    t.bigint "reporter_id", null: false
    t.bigint "reported_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reported_id"], name: "index_reports_on_reported_id"
    t.index ["reporter_id"], name: "index_reports_on_reporter_id"
  end

  create_table "stress_diagnoses", force: :cascade do |t|
    t.integer "stress_count"
    t.bigint "diary_id", null: false
    t.boolean "answer1"
    t.boolean "answer2"
    t.boolean "answer3"
    t.boolean "answer4"
    t.boolean "answer5"
    t.boolean "answer6"
    t.boolean "answer7"
    t.boolean "answer8"
    t.boolean "answer9"
    t.boolean "answer10"
    t.boolean "answer11"
    t.boolean "answer12"
    t.boolean "answer13"
    t.boolean "answer14"
    t.boolean "answer15"
    t.boolean "answer16"
    t.boolean "answer17"
    t.boolean "answer18"
    t.boolean "answer19"
    t.boolean "answer20"
    t.boolean "answer21"
    t.boolean "answer22"
    t.boolean "answer23"
    t.boolean "answer24"
    t.boolean "answer25"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_stress_diagnoses_on_diary_id"
  end

  create_table "sympathies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_sympathies_on_diary_id"
    t.index ["user_id", "diary_id"], name: "index_sympathies_on_user_id_and_diary_id", unique: true
    t.index ["user_id"], name: "index_sympathies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.integer "total_sympathy_counts", default: 0, null: false
    t.integer "total_like_counts", default: 0, null: false
    t.integer "total_sympathy_counts_in_past_month", default: 0, null: false
    t.integer "total_sympathy_counts_in_past_week", default: 0, null: false
    t.integer "total_like_counts_in_past_month", default: 0, null: false
    t.integer "total_like_counts_in_past_week", default: 0, null: false
    t.string "hobby1"
    t.string "hobby2"
    t.string "hobby3"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmarks", "means"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "diaries", "users"
  add_foreign_key "diary_comments", "diaries"
  add_foreign_key "diary_comments", "users"
  add_foreign_key "favorites", "diaries"
  add_foreign_key "favorites", "users"
  add_foreign_key "happy_diagnoses", "diaries"
  add_foreign_key "likes", "means"
  add_foreign_key "likes", "users"
  add_foreign_key "mean_comments", "means"
  add_foreign_key "mean_comments", "users"
  add_foreign_key "means", "users"
  add_foreign_key "reports", "users", column: "reported_id"
  add_foreign_key "reports", "users", column: "reporter_id"
  add_foreign_key "stress_diagnoses", "diaries"
  add_foreign_key "sympathies", "diaries"
  add_foreign_key "sympathies", "users"
end
