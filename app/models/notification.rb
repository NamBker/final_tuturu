class Notification < ApplicationRecord
  belongs_to :notified_by, class_name: 'User'  
  belongs_to :user  
  belongs_to :food
  validates :user_id, :notified_by_id, :food_id, :notice_type, presence: true
end
