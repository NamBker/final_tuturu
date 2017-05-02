class Food < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :impressions, as: :impressionable

  validates :name, presence: true
  validates_length_of :name, maximum: 25

  mount_uploader :file, AvatarUploader
  acts_as_votable
  acts_as_taggable
  is_impressionable # counter_cache: true, column_name: :visits, :unique => :all
  ratyrate_rateable "price"

  def score
    self.get_upvotes.size
  end

  def impression_count
    impressions.size
  end

  def unique_impression_count
    impressions.group(:ip_address).size.keys.length #TESTED
  end

  def overall_ratings(food)
    array = Rate.where(rateable_id: id, rateable_type: 'Food')
    stars = array.map {|food| food.stars }
    star_count = stars.count
    stars_total = stars.inject(0){|sum,x| sum + x }
    score = stars_total / (star_count.nonzero? || 1)
  end

  def avg_rating_dimension_price(food)
    array = Rate.where(rateable_id: id, rateable_type: 'Food').where(dimension: "price")
    stars = array.map {|food| food.stars }
    star_count = stars.count
    stars_total = stars.inject(0){|sum,x| sum + x }
    score = stars_total / (star_count.nonzero? || 1)
  end
end
