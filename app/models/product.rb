class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  attachment :image
  has_many :product_hashtags
  has_many :hashtags, through: :product_hashtags
  has_many :comments
  has_many :favorites
  has_many :like_users, through: :favorites, source: :user
  has_many :notifications, dependent: :destroy




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

  def like(user)
    favorites.find_or_create_by(user_id: user.id)
  end

  def unlike(user)
    favorites.find_by(user_id: user.id).destroy
  end

  def like?(user)
    like_users.include?(user)
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and product_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        product_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(product_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      product_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
