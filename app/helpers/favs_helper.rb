module FavsHelper
	def user_fav
    @user_fav ||= @post.faved_by(current_user)
  end
end
