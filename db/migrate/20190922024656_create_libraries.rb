class CreateLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :libraries do |t|
      t.string "name"
      t.string "location"
      t.integer "borrow_duration"
      t.float "fine_per_day"
      t.references :universities, foreign_key: true
    end
  end
end
