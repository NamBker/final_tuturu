class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food

  def create
    @comment = @food.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to :back
    else
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
