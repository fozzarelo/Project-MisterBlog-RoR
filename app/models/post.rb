class Post < ActiveRecord::Base
	validates(:title, {presence: true, uniqueness: {message: "must be unique!"}})
   validates(:body, {presence: true})

	has_many :likes, dependent: :destroy
	has_many :liking_users, through: :likes, source: :user

	has_many :taggings, dependent: :destroy
	has_many :categories, through: :taggings

	belongs_to :user
	has_many :comments, dependent: :destroy

  def self.search(word)
			where('title ILIKE ? OR body ILIKE ?', "%#{word}%", "%#{word}%")
	end
end
