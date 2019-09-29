class CreateTransactionLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_logs do |t|
      t.references :books, foreign_key: true
      t.references :users, foreign_key: true
      t.string "action"
      t.datetime "timestamp_of_action"
      # t.index ["books_id"], name: "index_transaction_log_on_books_id"
      # t.index ["users_id"], name: "index_transaction_log_on_users_id"
    end
  end
end
