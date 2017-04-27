class NewsfeedController < ApplicationController
	def index
		@user  = User.find(current_user.id)
		@users = User.all
	end
end
