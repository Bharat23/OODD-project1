class CreateLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :libraries do |t|
      t.string "name"
      t.string "location"
      t.integer "borrow_duration"
      t.float "fine_per_day"
    end
  end
end
