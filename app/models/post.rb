class Post < ActiveRecord::Base
	validates(:title, {presence: true, uniqueness: {message: "must be unique!"}})
   validates(:body, {presence: true})

	has_many :likes, dependent: :destroy
	has_many :users, through: :likes

	has_many :favs, dependent: :destroy
	has_many :fav_users, through: :favs, source: :user

	has_many :taggings, dependent: :destroy
	has_many :categories, through: :taggings

	belongs_to :user

	has_many :comments, dependent: :destroy

  def self.search(word)
			where('title ILIKE ? OR body ILIKE ?', "%#{word}%", "%#{word}%")
	end

	def like_for(user)
     likes.find_by_user_id user if user
  end

	def liked_by(user)
  	likes.find_by_user_id(user.id).present?
	end

	def faved_by(user)
  	favs.find_by_user_id user if user
	end


end
