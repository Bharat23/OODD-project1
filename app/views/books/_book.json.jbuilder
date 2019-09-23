json.extract! book, :id, :isbn, :title, :author, :language, :date_published, :edition, :front_cover_img, :subject, :summary, :special_collection, :created_at, :updated_at
json.url book_url(book, format: :json)
