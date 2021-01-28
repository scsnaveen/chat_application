class User < ApplicationRecord
	attr_accessor :gauth_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :google_authenticatable,:database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable,:trackable,
         :lockable,:timeoutable
   validates :last_name, presence: true,length: { maximum: 10 },format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" }
   validates :first_name, presence: true,length: { maximum: 10 },format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" }
   validates :user_name,presence: true
   mount_uploader :profile_pic, AvatarUploader,presence: true
	def after_confirmation
		UserMailer.welcome_email(self).deliver
	end
	  has_friendship

	has_many :posts
	 has_many :friend_sent, class_name: 'Friendship',
                          foreign_key: 'sent_by_id',
                          inverse_of: 'sent_by',
                          dependent: :destroy
    has_many :friend_request, class_name: 'Friendship',
                          foreign_key: 'sent_to_id',
                          inverse_of: 'sent_to',
                          dependent: :destroy
    has_many :friends, -> { merge(Friendship.friends) },
            through: :friend_sent, source: :sent_to
    has_many :pending_requests, -> { merge(Friendship.not_friends) },
            through: :friend_sent, source: :sent_to
    has_many :received_requests, -> { merge(Friendship.not_friends) },
           through: :friend_request, source: :sent_by
end
