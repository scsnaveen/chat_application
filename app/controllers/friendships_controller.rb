class FriendshipsController < ApplicationController
	before_action :authenticate_user!
			def index
				@user = current_user
				@friends = @user.friends
				@requests = @user.requested_friends
				@pending = @user.pending_friends
				@blocked= @user.blocked_friends
		end

		def create        
				@user = current_user
				friend = User.find_by(id: params[:id])
				@user.friend_request(friend)
				UserMailer.friend_request_mail(friend).deliver
				redirect_to friendships_path
		end

		def add
				@user = current_user
				friend = User.find_by(id: params[:id])
				@user.accept_request(friend)
				redirect_to friendships_path
		end

		def block
				@user = current_user
				friend = User.find_by(id: params[:id])
				@user.block_friend(friend)

				redirect_to friendships_path
		end
		def unblock
			@user = current_user
				friend = User.find_by(id: params[:id])
				@user.unblock_friend(friend)

				redirect_to friendships_path
		end
		def reject
				@user = current_user
				friend = User.find_by(id: params[:id])
				@user.decline_request(friend)

				redirect_to friendships_path
		end

		def remove
				@user = current_user
				friend = User.find_by(id: params[:id])
				@user.remove_friend(friend)

				redirect_to user_path(friend)
		end

		def search
				@search = params[:search].downcase
				@results = User.all.select do |user|
						user.user_name.downcase.include?(@search)
				end
		end

		def show
				
		end
end
