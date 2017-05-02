class StreamsController < ApplicationController
  def index
    @user = current_user.following
  end
end
