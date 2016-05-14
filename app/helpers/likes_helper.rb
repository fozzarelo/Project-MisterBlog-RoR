module LikesHelper
	def user_like
    @user_like ||= @post.like_for(current_user)
  end
end
