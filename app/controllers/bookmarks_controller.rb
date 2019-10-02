class BookmarksController < ApplicationController

  def view_bookmark
    user_id = current_user.id
    @bookmark = Bookmark.where('users_id = ?', user_id).pluck(:books_id)

    @book = Book.where(id: @bookmark)

  end

  def destroy
    book_id = params[:book_id]
    puts "++++++++++++++++++++++ #{book_id} ++++++++++++++++++++++++++"
    Bookmark.where(books_id: book_id).destroy_all
    respond_to do |format|
      format.html { redirect_to request.referrer , notice: 'Bookmark deleted :(' }
    end

  end


end
