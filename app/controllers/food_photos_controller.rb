class FoodPhotosController < ApplicationController
  def destroy
    @food_photo = FoodPhoto.find_by id: params[:id]
    @food = @food_photo.food
    @food_photo.destroy
    respond_to do |format|
      format.html {redirect_to food_path(@food), notice: 'Photo was successfully deleted.'}
    end
  end
end
