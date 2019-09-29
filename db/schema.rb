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

ActiveRecord::Schema.define(version: 2019_09_26_024927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_issue_transactions", force: :cascade do |t|
    t.bigint "users_id"
    t.bigint "books_id"
    t.bigint "libraries_id"
    t.string "status"
    t.date "due_date"
    t.date "last_updated"
    t.string "reason"
    t.float "fine_amount"
    t.index ["books_id"], name: "index_book_issue_transactions_on_books_id"
    t.index ["libraries_id"], name: "index_book_issue_transactions_on_libraries_id"
    t.index ["users_id"], name: "index_book_issue_transactions_on_users_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "users_id"
    t.bigint "books_id"
    t.index ["books_id"], name: "index_bookmarks_on_books_id"
    t.index ["users_id"], name: "index_bookmarks_on_users_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.string "author"
    t.string "language"
    t.date "date_published"
    t.integer "edition"
    t.string "front_cover_img"
    t.string "subject"
    t.text "summary"
    t.boolean "special_collection"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.integer "borrow_duration"
    t.float "fine_per_day"
  end

  create_table "library_book_mappings", force: :cascade do |t|
    t.bigint "libraries_id"
    t.bigint "books_id"
    t.integer "book_count"
    t.index ["books_id"], name: "index_library_book_mappings_on_books_id"
    t.index ["libraries_id"], name: "index_library_book_mappings_on_libraries_id"
  end

  create_table "transaction_logs", force: :cascade do |t|
    t.bigint "books_id"
    t.bigint "users_id"
    t.string "action"
    t.datetime "timestamp_of_action"
    t.index ["books_id"], name: "index_transaction_logs_on_books_id"
    t.index ["users_id"], name: "index_transaction_logs_on_users_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "university_library_mappings", force: :cascade do |t|
    t.bigint "libraries_id"
    t.bigint "universities_id"
    t.index ["libraries_id"], name: "index_university_library_mappings_on_libraries_id"
    t.index ["universities_id"], name: "index_university_library_mappings_on_universities_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role"
    t.string "name"
    t.bigint "universities_id"
    t.bigint "libraries_id"
    t.string "educational_level"
    t.integer "borrowing_limit", default: 0
    t.integer "is_approved", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["libraries_id"], name: "index_users_on_libraries_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["universities_id"], name: "index_users_on_universities_id"
  end

  add_foreign_key "book_issue_transactions", "books", column: "books_id"
  add_foreign_key "book_issue_transactions", "libraries", column: "libraries_id"
  add_foreign_key "book_issue_transactions", "users", column: "users_id"
  add_foreign_key "bookmarks", "books", column: "books_id"
  add_foreign_key "bookmarks", "users", column: "users_id"
  add_foreign_key "library_book_mappings", "books", column: "books_id"
  add_foreign_key "library_book_mappings", "libraries", column: "libraries_id"
  add_foreign_key "transaction_logs", "books", column: "books_id"
  add_foreign_key "transaction_logs", "users", column: "users_id"
  add_foreign_key "university_library_mappings", "libraries", column: "libraries_id"
  add_foreign_key "university_library_mappings", "universities", column: "universities_id"
  add_foreign_key "users", "libraries", column: "libraries_id"
  add_foreign_key "users", "universities", column: "universities_id"
end
