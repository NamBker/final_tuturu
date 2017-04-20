class FoodsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :upvote, :downvote]
  before_filter :require_permission, only: [:edit, :update]
  before_action :set_food, except: [:new, :create, :index]

  def index
    @search = Food.ransack params[:q]
    @search.sorts = %w(created_at asc) if @search.sorts.empty?
    @foods = @search.result.page(params[:page]).per_page Settings.limit
  end

  def show
    # @like = (current_user.voted_for? @food) && (@food.liked_by current_user)
    # p @like
  end

  def new
    @food = Food.new
  end

  def edit
  end

  def create
    @food = Food.new food_params
    @food.user_id = current_user.id
    if @food.save
      flash[:success] = "Upload success"
      redirect_to food_path @food
    else
      render :new
    end
  end

  def update
    if @food.update_attributes food_params
      flash[:success] = "Update success"
      redirect_to food_path @food
    else
      render :edit
    end
  end

  def destroy
    if @food.destroy
      flash[:success] = "Deleted complete."
    else
      flash[:danger] = "Something wrong"
    end
    respond_to do |format|
      format.html {redirect_to :back}
      format.json {head :no_content}
    end
  end

  def upvote
    p current_user.id
    # @food = Food.find_by id: params[:id]
    @food.upvote_by current_user
    redirect_to :back
  end

  def downvote
    # @food = Food.find_by id: params[:id]
    @food.downvote_by current_user
    redirect_to :back
  end
  
  private
    def set_food
      @food = Food.find_by id: params[:id]
    end

    def food_params
      params.require(:food).permit :name, :address, :price, :description, :tag, :review, :file
    end

  def require_permission
    if current_user != Food.find(params[:id]).user
      redirect_to root_path
    end
  end
end
