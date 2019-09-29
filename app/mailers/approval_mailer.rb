class ApprovalMailer < ApplicationMailer
    default from: 'bsinha2@ncsu.edu'

    def account_approve_email(id)
        subject = 'Congrat! You are approved.'
        @user = User.find(id)
        mail(to: @user.email, subject: subject)
    end
end
