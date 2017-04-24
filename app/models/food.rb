class Food < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  # validates :price, numericality: {greater_than: 0}

  mount_uploader :file, AvatarUploader
  acts_as_votable

  def score
    self.get_upvotes.size
  end
end
