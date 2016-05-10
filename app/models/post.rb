class Post < ActiveRecord::Base
	validates(:title, {presence: true, uniqueness: {message: "must be unique!"}})
   validates(:body, {presence: true})

  belongs_to :user
  has_many :comments, dependent: :destroy

  def self.search(word)
			where('title ILIKE ? OR body ILIKE ?', "%#{word}%", "%#{word}%")
	end
end
