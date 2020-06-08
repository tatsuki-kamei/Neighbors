class Category < ApplicationRecord
	has_many :products
	has_many :users, through: :user_categories
  	has_many :user_categories
  	has_ancestry
end
