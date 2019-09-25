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

ActiveRecord::Schema.define(version: 2019_09_25_042020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_issue_transactions", force: :cascade do |t|
    t.bigint "students_id"
    t.bigint "books_id"
    t.bigint "libraries_id"
    t.string "status"
    t.date "due_date"
    t.date "last_updated"
    t.string "reason"
    t.float "fine_amount"
    t.index ["books_id"], name: "index_book_issue_transactions_on_books_id"
    t.index ["libraries_id"], name: "index_book_issue_transactions_on_libraries_id"
    t.index ["students_id"], name: "index_book_issue_transactions_on_students_id"
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

  create_table "librarians", force: :cascade do |t|
    t.string "name"
    t.bigint "libraries_id"
    t.index ["libraries_id"], name: "index_librarians_on_libraries_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.integer "borrow_duration"
    t.float "total_overdue"
  end

  create_table "library_book_mapping", force: :cascade do |t|
    t.bigint "libraries_id"
    t.bigint "books_id"
    t.integer "book_count"
    t.index ["books_id"], name: "index_library_book_mapping_on_books_id"
    t.index ["libraries_id"], name: "index_library_book_mapping_on_libraries_id"
  end

  create_table "students", force: :cascade do |t|
    t.bigint "users_id"
    t.string "name"
    t.string "university"
    t.string "educational_level"
    t.integer "borrowing_limit"
    t.index ["users_id"], name: "index_students_on_users_id"
  end

  create_table "transaction_log", force: :cascade do |t|
    t.bigint "books_id"
    t.bigint "users_id"
    t.string "action"
    t.datetime "timestamp_of_action"
    t.index ["books_id"], name: "index_transaction_log_on_books_id"
    t.index ["users_id"], name: "index_transaction_log_on_users_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
  end

  create_table "university_library_mapping", force: :cascade do |t|
    t.bigint "libraries_id"
    t.bigint "universities_id"
    t.index ["libraries_id"], name: "index_university_library_mapping_on_libraries_id"
    t.index ["universities_id"], name: "index_university_library_mapping_on_universities_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "role"
    t.string "username"
    t.string "password"
  end

  add_foreign_key "book_issue_transactions", "libraries", column: "libraries_id"
  add_foreign_key "book_issue_transactions", "students", column: "students_id"
  add_foreign_key "librarians", "libraries", column: "libraries_id"
  add_foreign_key "library_book_mapping", "libraries", column: "libraries_id"
  add_foreign_key "students", "users", column: "users_id"
  add_foreign_key "transaction_log", "users", column: "users_id"
  add_foreign_key "university_library_mapping", "libraries", column: "libraries_id"
  add_foreign_key "university_library_mapping", "universities", column: "universities_id"
end
