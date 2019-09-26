class CreateUniversityLibraryMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :university_library_mappings do |t|
      t.references :libraries, foreign_key: true
      t.references :universities, foreign_key: true
      # t.index ["libraries_id"], name: "index_university_library_mapping_on_libraries_id"
      # t.index ["universities_id"], name: "index_university_library_mapping_on_universities_id"
    end
  end
end
