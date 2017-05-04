class UsersController < ApplicationController
  def index
    @users = User.all
    @user= User.find(current_user.id)
  end

  def show
   @user  = User.find(params[:id])
 end

   def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
end
