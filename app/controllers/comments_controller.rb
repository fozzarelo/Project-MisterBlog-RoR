class CommentsController < ApplicationController
  before_action :authenticate_user!

# TODO why couldn't I require params post id?
  def create
		find_post
	  comment_params = params.require(:comment).permit(:body, :post_id)
	  @comment = Comment.new(comment_params)
	  @comment.post_id = @post.id
 		@comment.user_id = current_user.id
	 	respond_to do |format|
	  	if @comment.save
				CommentsMailer.notify_post_owner(@comment).deliver_now
				format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
				format.js { render :create_success }
	  	else
				format.html { render "/posts/show", notice: 'Error saving comment'}
				format.js { render :create_failure }
			end
  	end
	end

	def edit
    find_comment
		find_post
  end


	def destroy
		find_comment
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to post_path(@post), notice: 'Comment deleted' }
	    format.js { render }
		end
	end
	def update
		find_comment
		respond_to do |format|
			if @comment.update(comment_params)
				#format.html { redirect_to @comment, notice: 'Post was successfully updated.' }
				format.js { render :update_success }
			else
				#format.html { render :edit }
				format.js { render :update_failure }
			end
		end
	end

	private

		def find_comment
			@comment = Comment.find(params[:id])
		end

		def find_post
			@post = Post.find params[:post_id]
		end

		def comment_params
			params.require(:comment).permit(:body)
		end

end
