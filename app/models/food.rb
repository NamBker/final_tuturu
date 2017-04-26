class Food < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :impressions, as: :impressionable

  validates :name, presence: true
  # validates :price, numericality: {greater_than: 0}

  mount_uploader :file, AvatarUploader
  acts_as_votable
  acts_as_taggable
  is_impressionable # counter_cache: true, column_name: :visits, :unique => :all

  def score
    self.get_upvotes.size
  end

  def impression_count
    impressions.size
  end

  def unique_impression_count
    impressions.group(:ip_address).size.keys.length #TESTED
  end
end
