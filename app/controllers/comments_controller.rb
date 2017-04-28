class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food

  def index
    @comments = @food.comment.all
  end

  def edit
    @comment = @food.comments.find_by id: params[:id]
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment = @food.comments.find_by id: params[:id]
    if @comment.update(comment_params)
      respond_to do |format|
        format.html {redirect_to food_path(@food)}
        format.js
      end
    else
      flash[:alert] = "Something worng, try again"
      render :back
    end
  end

  def create
    @comment = @food.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html { redirect_to food_path(@food) }
        format.js
      end
    else
      flash[:alert] = "Something went wrong."
      render food_path(@food)
    end
  end

  def destroy
    @comment = @food.comments.find_by id: params[:id]
    @comment.destroy
    respond_to do |format|
      format.html do
        redirect_to @food
      end
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :image
  end

  def set_food
    @food = Food.find_by id: params[:food_id]
  end
end
