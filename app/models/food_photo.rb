class FoodPhoto < ApplicationRecord
  mount_uploader :photo, AvatarUploader
  belongs_to :food
end
