class CommentsController < ApplicationController
  before_action :authenticate_user!

# TODO why couldn't I require params post id?
  def create
	  	 @post = Post.find params[:post_id]
	    comment_params = params.require(:comment).permit(:body, :post_id)
	    @comment = Comment.new(comment_params)
	    @comment.post_id = @post.id
       @comment.user_id = current_user.id
	    if @comment.save
		 	respond_to do |format|
				format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
				# format.json { render :show, status: :created, location: @comment }
			end
	    else
			respond_to do |format|
				format.html { render "/posts/show", notice: 'Error saving comment'}
				#format.json { render json: @comment.errors, status: :unprocessable_entity }
			end

	    end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@post = Post.find params[:post_id]
		if @comment.destroy
			respond_to do |format|
				format.html { redirect_to post_path(@post), notice: 'Comment was successfully destroyed.' }
		      format.json { head :no_content }
			end
		else
			render "fail"
		end
	end


end
