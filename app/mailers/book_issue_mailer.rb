class BookIssueMailer < ApplicationMailer
    default from: 'bsinha2@ncsu.edu'

    def welcome_email
        mail(to: 'bsinha2@ncsu.edu', subject: 'Bhakkk')
    end
end
