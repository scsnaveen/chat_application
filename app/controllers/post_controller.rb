class PostController < ApplicationController
	def new
		@post =Post.new
	end
  def create
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id
  	if @post.save!
  		redirect_to :welcome_index,notice:  "Post added to you profile"
  	end
  end

  def index
  	@posts = Post.all
  end

  def delete
  	@post=Post.find(params[:id])
  	@post.destroy
  end
  def post_params
  	params.permit(:post,:user_id)
  end
end
