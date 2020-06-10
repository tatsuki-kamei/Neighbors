class Product < ApplicationRecord
  belongs_to :category
  attachment :image
end
