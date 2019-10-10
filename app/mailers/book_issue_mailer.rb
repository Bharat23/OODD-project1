class BookIssueMailer < ApplicationMailer
    default from: 'bsinha2@ncsu.edu'

    def book_issued_email(id, book_id)
        subject = 'Book was issued!'
        @user = User.find(id)
        @book = Book.find(book_id)
        mail(to: @user.email, subject: subject)
    end
end
