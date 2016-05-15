class LikesController < ApplicationController
	before_action :authenticate_user!
  before_action :set_post

  def create
		:authorize_like
    like      = Like.new
    like.user = current_user
    like.post = @post
    respond_to do |format|
      if like.save
        format.html { redirect_to post_path(@post), notice: "Liked!" }
			  format.js   { render } # likes/create.js.erb
      else
        format.html { redirect_to post_path(@post), alert: "You've already liked!" }
        format.js   { render js: "alert('Can\'t like, please refresh the page!');" }
      end
    end
  end

  def destroy
		:authorize_destroy
		like = current_user.likes.find params[:id]
    like.destroy
    respond_to do |format|
      format.html { redirect_to post_path(like.post_id), notice: "Un-liked!" }
      format.js { render }
    end
  end

	def authorize_like
    redirect_to post, notice: "Can't like!" unless can? :like, post
  end

  def authorize_destroy
    redirect_to post, notice: "Can't remove like!" unless can? :destroy, like
  end

  def set_post
    @post ||= Post.find params[:post_id]
  end
end
