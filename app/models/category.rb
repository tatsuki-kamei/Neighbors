class Category < ApplicationRecord
  has_many :products
  has_many :users, through: :user_categories
  has_many :user_categories, dependent: :destroy
  has_ancestry
end
