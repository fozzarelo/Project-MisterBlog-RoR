class FavsController < ApplicationController
	before_action :authenticate_user!


	def index
		@favs = Fav.find_faved_by(current_user)
	end

  def create
		set_post
		authorize_fav
    fav      = Fav.new
    fav.user = current_user
    fav.post = @post
    respond_to do |format|
      if fav.save
        format.html { redirect_to post_path(@post), notice: "Faved!" }
			#  format.js   { render } # favs/create.js.erb
      else
        format.html { redirect_to post_path(@post), alert: "You've already favd!" }
      #  format.js   { render js: "alert('Can\'t fav, please refresh the page!');" }
      end
    end
  end

  def destroy
		set_post
		@fav = current_user.favs.find params[:id]
		authorize_destroy
    @fav.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@fav.post_id), notice: "Un-faved!" }
      format.js { render }
    end
  end

	def authorize_fav
    redirect_to post, notice: "Can't fav!" unless can? :create, @post
  end

  def authorize_destroy
    redirect_to post, notice: "Can't remove fav!" unless can? :destroy, @fav
  end

  def set_post
    @post ||= Post.find params[:post_id]
  end
end
