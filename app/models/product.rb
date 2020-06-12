class Product < ApplicationRecord
  belongs_to :category
  attachment :image
  has_many :product_hashtags
  has_many :hashtags, through: :product_hashtags
  has_many :comments

  

  after_create do
		product = Product.find_by(id: self.id)
		hashtags  = self.text.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
		hashtags.uniq.map do |hashtag|
		  	#ハッシュタグは先頭の'#'を外した上で保存
			tag = Hashtag.find_or_create_by(hashname: hashtag.delete('#'))
			product.hashtags << tag
    	end
  	end
 
	before_update do 
	    product = Product.find_by(id: self.id)
	    product.hashtags.clear
	    hashtags = self.text.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
	    hashtags.uniq.map do |hashtag|
      		tag = Hashtag.find_or_create_by(hashname: hashtag.delete('#'))
      		product.hashtags << tag
    	end
    end
end
