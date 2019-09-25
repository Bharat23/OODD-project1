require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "Books"
  end

  test "creating a Book" do
    visit books_url
    click_on "New Book"

    fill_in "Author", with: @book.author
    fill_in "Date published", with: @book.date_published
    fill_in "Edition", with: @book.edition
    fill_in "Front cover img", with: @book.front_cover_img
    fill_in "Isbn", with: @book.isbn
    fill_in "Language", with: @book.language
    check "Special collection" if @book.special_collection
    fill_in "Subject", with: @book.subject
    fill_in "Summary", with: @book.summary
    fill_in "Title", with: @book.title
    click_on "Create Book"

    assert_text "Book was successfully created"
    click_on "Back"
  end

  test "updating a Book" do
    visit books_url
    click_on "Edit", match: :first

    fill_in "Author", with: @book.author
    fill_in "Date published", with: @book.date_published
    fill_in "Edition", with: @book.edition
    fill_in "Front cover img", with: @book.front_cover_img
    fill_in "Isbn", with: @book.isbn
    fill_in "Language", with: @book.language
    check "Special collection" if @book.special_collection
    fill_in "Subject", with: @book.subject
    fill_in "Summary", with: @book.summary
    fill_in "Title", with: @book.title
    click_on "Update Book"

    assert_text "Book was successfully updated"
    click_on "Back"
  end

  test "destroying a Book" do
    visit books_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Book was successfully destroyed"
  end
end
