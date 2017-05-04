class NewsfeedController < ApplicationController
	def index
		@user  = User.find(current_user.id)
		@users = User.all
		@foods = Food.all.order('created_at DESC').page params[:page]
	end
end
