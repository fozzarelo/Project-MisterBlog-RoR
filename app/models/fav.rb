class Fav < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
	validates :user_id, uniqueness: {scope: :post_id}

	def self.find_faved_by(user)
			where('user_id = ?',"#{user.id}")
	end
end
