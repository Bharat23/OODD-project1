class CreateBookIssueTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :book_issue_transactions do |t|
      t.references :users, foreign_key: true
      t.references :books, foreign_key: true
      t.references :libraries, foreign_key: true
      t.string "status"
      t.date "due_date"
      t.date "last_updated"
      t.string "reason"
      t.float "fine_amount"
      # t.index ["books_id"], name: "index_book_issue_transactions_on_books_id"
      # t.index ["libraries_id"], name: "index_book_issue_transactions_on_libraries_id"
      # t.index ["students_id"], name: "index_book_issue_transactions_on_students_id"
    end
  end
end
