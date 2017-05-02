class FoodsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :upvote, :downvote, :newest, :liked, :tag]
  before_action :set_food, except: [:new, :create, :index]
  before_filter :require_permission, only: [:edit, :update]
  before_filter :log_impression, only: [:show]
  autocomplete :tag, :name, class_name: 'ActsAsTaggableOn::Tag'

  def index
    q = params[:q]
    @foods = Food.ransack(name_or_description_or_review_cont: params[:q]).result.page(params[:page]).per_page(4)
    @users = User.ransack(username_or_name_cont: params[:q]).result.page(params[:page]).per_page(4)
  end

  def show
    @comment = Comment.new
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
      flash[:alert] = "Deleted complete."
    else
      flash[:danger] = "Something wrong"
    end
    respond_to do |format|
      format.html {redirect_to :back}
      format.json {head :no_content}
    end
  end

  def upvote
    @food.upvote_by current_user
    create_notification @food
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def downvote
    @food.downvote_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def newest
    @search = Food.ransack params[:q]
    @search.sorts = %w(created_at\ desc) if @search.sorts.empty?
    @foods = @search.result.page(params[:page]).per_page Settings.limit
  end

  def liked
    @search = Food.ransack params[:q]
    @search.sorts = %w(cached_votes_up\ desc) if @search.sorts.empty?
    @foods = @search.result.page(params[:page]).per_page Settings.limit
  end

  def tag
    @foods = if params[:tag]
      Food.tagged_with(params[:tag])
    else
      Food
    end
    .page(params[:page]).per_page Settings.limit
  end

  private
    def set_food
      @food = Food.find_by id: params[:id]
    end

    def food_params
      params.require(:food).permit :name, :address, :price, :description, :review, :file, :tag_list
    end

  def require_permission
    if current_user != Food.find(params[:id]).user
      redirect_to root_path
    end
  end

  def log_impression
    @food = Food.find_by id: params[:id]
    @food.impressions.create(ip_address: request.remote_ip)
  end

  def create_notification(food)
    return if food.user.id == current_user.id 
    Notification.create!(user_id: food.user.id,
                        notified_by_id: current_user.id,
                        food_id: food.id,
                        notice_type: 'like')
   end  
end
