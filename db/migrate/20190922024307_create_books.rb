class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :isbn, uniqueness: true
      t.string :title
      t.string :author
      t.string :language
      t.date :date_published
      t.integer :edition
      t.string :front_cover_img
      t.string :subject
      t.text :summary
      t.boolean :special_collection
      t.references :libraries, foreign_key: true
      t.integer "book_count"
    end
  end
end
