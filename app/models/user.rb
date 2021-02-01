class User < ApplicationRecord
	attr_accessor :gauth_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :google_authenticatable,:database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable,:trackable,
         :lockable,:timeoutable
  #validations for the user 
   validates :password, presence: true,length: {minimum: 6, maximum: 10 },format: { :with => /\A^(?=.*[A-Z])(?=.*\d.*)(?=.*\W.*)[a-zA-Z0-9\S]{1,15}$\z/, message: "Password should contain an upper case letter,a number, a special symbol from [@#$%&] and an optional lower case letter "}
   validates :email, presence: true,format: { :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/ }
   validates :last_name, presence: true,length: { maximum: 10 },format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" }
   validates :first_name, presence: true,length: { maximum: 10 },format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" }
   validates :user_name,presence: true,uniqueness: true 

   mount_uploader :profile_pic, AvatarUploader,presence: true
    has_friendship
    # belongs_to :role
    has_many :posts
    has_many :messages
    has_many :conversations, foreign_key: :sender_id
	def after_confirmation
		UserMailer.welcome_email(self).deliver
	end
	

	def friends?
        self.friends
    end

    def friend_requests?
        self.requested_friends.any?
    end

    def requested_friends?
        self.pending_friends.any?
    end

    def invite_friend(user)
        self.friend_request(user)
    end

    def not_friends
        potential = []
        User.all.each do |user|
            if(self.friends_with?(user) != true && self != user && self.friends.include?(user) != true && self.pending_friends.include?(user) != true && self.requested_friends.include?(user) != true)
                potential << user
            end
        end
        potential
    end
end
