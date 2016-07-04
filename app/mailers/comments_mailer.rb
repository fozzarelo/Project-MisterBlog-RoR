class CommentsMailer < ApplicationMailer
	def notify_post_owner(comment)
		@comment = comment
		@post = comment.post
		@owner = @post.user
		return unless @owner
		mail(to: @owner.email, subject: "You got a new comment")
	end
		
end
