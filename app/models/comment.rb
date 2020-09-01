class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :product, dependent: :destroy
	has_many :notifications, dependent: :destroy
end
