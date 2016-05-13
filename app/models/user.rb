class User < ActiveRecord::Base
	has_secure_password

	validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy

	def full_name
		full_name = "#{self.first_name} #{self.last_name}"
	end

end
