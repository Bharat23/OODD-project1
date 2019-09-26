class CreateLibraryBookMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :library_book_mappings do |t|
      t.references :libraries, foreign_key: true
      t.references :books, foreign_key: true
      t.integer "book_count"
      # t.index ["books_id"], name: "index_library_book_mapping_on_books_id"
      # t.index ["libraries_id"], name: "index_library_book_mapping_on_libraries_id"
    end
  end
end
