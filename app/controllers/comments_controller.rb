class CommentsController < ApplicationController
  before_action :authenticate_user!

# TODO why couldn't I require params post id?
  def create
		@post = Post.find params[:post_id]
	  comment_params = params.require(:comment).permit(:body, :post_id)
	  @comment = Comment.new(comment_params)
	  @comment.post_id = @post.id
 		@comment.user_id = current_user.id
	 	respond_to do |format|
	  	if @comment.save
				format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
				format.js { render :create_success }
	  	else
				format.html { render "/posts/show", notice: 'Error saving comment'}
				format.js { render :create_failure }
			end
  	end
	end

	def destroy
		@comment = Comment.find(params[:id])
		#@post = Post.find params[:post_id]
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to post_path(@post), notice: 'Comment deleted' }
	    format.js { render }
		end
	end
end
