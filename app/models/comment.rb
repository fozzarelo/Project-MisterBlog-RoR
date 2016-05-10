class Comment < ActiveRecord::Base

	validates(:body, {presence: true})
   validates(:post_id, {presence: true})
   validates(:body, uniqueness: {scope: :post_id})
	
	belongs_to :user
	belongs_to :post
end
