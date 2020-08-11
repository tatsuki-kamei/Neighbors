class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :product
	validates :user_id, presence: true
	validates :product_id, presence: true
	has_many :notifications, dependent: :destroy
end
