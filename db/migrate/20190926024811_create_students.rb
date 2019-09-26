class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.references :users, foreign_key: true
      t.string "name"
      t.string "university"
      t.string "educational_level"
      t.integer "borrowing_limit"
      # t.index ["users_id"], name: "index_students_on_users_id"
    end
  end
end
