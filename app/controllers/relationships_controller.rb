
			format.html { redirect_to @user }
			format.html { redirect_to @user }
			format.js
			format.js
		@user = Relationship.find(params[:id]).followed
		@user = User.find(params[:followed_id])
		current_user.follow(@user)
		current_user.unfollow(@user)
		end
		end
		respond_to do |format|
		respond_to do |format|
	def create
	def destroy
	end
	end
class RelationshipsController < ApplicationController
end