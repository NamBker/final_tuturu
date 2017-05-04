class NewsfeedController < ApplicationController
	def index
		@user  = User.find(current_user.id)
		@users = User.all
		@foods = Food.all.order('created_at DESC').page params[:page]
		# @foods = Food.of_followed_users(current_user.following).order('created_at DESC').page params[:page]
		following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = #{current_user.id}"
  #   @foods = Food.where("user_id IN (#{following_ids})
  #                    OR user_id = :user_id",current_user.id)
	end
end
