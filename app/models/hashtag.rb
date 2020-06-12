class Hashtag < ApplicationRecord
  has_many :product_hashtags
  has_many :hashtags, through: :product_hashtags
  validates :hashname, presence: true, length: {maximum:99}
end
