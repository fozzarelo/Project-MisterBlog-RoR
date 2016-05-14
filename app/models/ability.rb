class Ability
	include CanCan::Ability

	CRUD = [:create, :read, :update, :destroy]


	def initialize(user)
		user ||= User.new
		can :manage, :all if user.admin?
		#can :manage, :all if user.admin?

		can :update, Post do |post|
			post.user == user
		end

		can :create, Post do |post|
			user.persisted?
		end

		can [:destory], Comment do |com|
			#can delete if you own the comment, or the post
			com.user == user || com.post.user == user
		end

		can [:create], Comment do |com|
			user.persisted?
		end

		can :like, Post do |pos|
			# can only like other users's posts
			user.persisted? && pos.user != user
		end

		can :destroy, Like do |lik|
			lik.user == user
		end

		can :destroy, Fav do |fav|
			fav.user == user
		end

	end
end
