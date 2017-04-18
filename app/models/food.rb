class Food < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: {greater_than: 0}

  # mount_uploader :file, AvatarUploader
  # serialize :files, JSON
  belongs_to :user
end
