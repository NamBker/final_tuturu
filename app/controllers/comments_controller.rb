class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food

  def create
    @comment = @food.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "You commented the hell out of that food!"
      redirect_to :back
    else
      flash[:alert] = "Check the comment form, something went horribly wrong."
      render food_path(@food)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @comment = @food.comments.find_by id: params[:id]
    @comment.destroy
    flash[:success] = "Comment deleted :("
    redirect_to food_path(@food)
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end

  def set_food
    @food = Food.find_by id: params[:food_id]
  end
end
