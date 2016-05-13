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
				com.user == user || com.post.user == user
         end

        can [:create], Comment do |com|
           user.persisted?
        end

		  can [:update, :destroy], Like do |lik|
			  user.persisted?
		  end

     end
end
