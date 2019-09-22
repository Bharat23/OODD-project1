ActiveRecord::Schema.define do

  create_table "libraries", force: :cascade do |t|
    t.string "name", uniqueness: true
    t.string "location"
    t.integer "borrow_duration"
    t.float "total_overdue"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name", uniqueness: true
  end

  create_table "university_library_mapping", force: :cascade do |t|
    t.references :libraries, foreign_key: true
    t.references :universities, foreign_key: true
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn", uniqueness: true
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

  create_table "users", force: :cascade do |t|
    t.string "role"
    t.string "username", uniqueness: true
    t.string "password"
  end

  create_table "students", force: :cascade do |t|
    t.references :users, foreign_key: true
    t.string "name"
    t.string "university"
    t.string "educational_level"
    t.integer "borrowing_limit"
  end

  create_table "librarians", force: :cascade do |t|
    t.string "name"
    t.references :libraries, foreign_key: true
  end

  create_table "bookmarks"
  t.references :students, foreign_key: true
  t.references :books, foreign_key: true
end

create_table "book_issue_transactions", force: :cascade do |t|
  t.references :students, foreign_key: true
  t.references :books, foreign_key: true
  t.references :libraries, foreign_key: true
  t.string "status", inclusion: {in: ["On Hold","Approved","Denied","Returned"]}
  t.date "due_date"
  t.date "last_updated"
  t.string "reason"
  t.float "fine_amount"
end

create_table "transaction_log", force: :cascade do |t|
  t.references :books, foreign_key: true
  t.references :users, foreign_key: true
  t.string "action"
  t.datetime "timestamp_of_action"
end

create_table "library_book_mapping", force: :cascade do |t|
  t.references :libraries, foreign_key: true
  t.references :books, foreign_key: true
  t.integer "book_count"
end
end