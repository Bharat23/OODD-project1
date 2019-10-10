class CreateWaitlist < ActiveRecord::Migration[6.0]
  def change
    create_table :waitlists do |t|
      t.references :books, foreign_key: true
      t.references :users, foreign_key: true
      t.datetime "created_at"
    end
  end
end
