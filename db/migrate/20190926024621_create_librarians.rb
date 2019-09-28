class CreateLibrarians < ActiveRecord::Migration[6.0]
  def change
    create_table :librarians do |t|
      t.string "name"
      t.references :libraries, foreign_key: true
      t.references :users, foreign_key: true
      # t.index ["libraries_id"], name: "index_librarians_on_libraries_id"
    end
  end
end
