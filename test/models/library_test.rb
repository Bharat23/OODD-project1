require 'test_helper'

class LibraryTest < ActiveSupport::TestCase
  test "library should have name" do
    library = Library.new
    assert_not library.save
  end

  test "library fine shouldn't be anything but numeric" do
    library = Library.new
    library.name = "New Name"
    library.fine_per_day = "asdasddad"
    assert_not library.save
  end

  test "library book issue duration shouldn't be anything but numeric" do
    library = Library.new
    library.name = "New Name"
    library.borrow_duration = "asdasddad"
    assert_not library.save
  end

  test "library should create value without university id" do
    library = Library.new
    library.name = "New Name"
    library.location = "New Location"
    library.fine_per_day = 1.5
    library.borrow_duration = 12
    assert library.save
  end
end
