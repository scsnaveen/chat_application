class UserMailer < ApplicationMailer
	def welcome_email(user)
		@user = user
		mail(:from =>"SYKAM GATES railschecking@gmail.com",to: @user.email, subject: "Welcome!")
	end
	def friend_request_mail(user)
		@user=user
		mail(:from =>"SYKAM GATES railschecking@gmail.com",to: @user.email, subject: "friend request")
	end
end
