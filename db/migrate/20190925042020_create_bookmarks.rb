class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.references :students, foreign_key: true
      t.references :books, foreign_key: true
    end
  end
end
