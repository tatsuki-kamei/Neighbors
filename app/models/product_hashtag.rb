class ProductHashtag < ApplicationRecord
	belongs_to :product
	belongs_to :hashtag
	validates  :product_id, presence: true
	validates  :hashtag_id,   presence: true
end