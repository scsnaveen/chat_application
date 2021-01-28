class UserMailer < ApplicationMailer
	def welcome_email(user)
    @user = user
    mail(:from =>"SYKAM GATES railschecking@gmail.com",to: @user.email, subject: "Welcome!")
  end
end
