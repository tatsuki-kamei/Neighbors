module NotificationsHelper
	def notification_form(notification)
      @visiter = notification.visitor
      @comment = nil
      your_product = link_to 'あなたの投稿', product_path(notification), style:"font-weight: bold;"
      @visiter_comment = notification.comment_id
      #notification.actionがfollowかlikeかcommentか
      case notification.action
        when "follow" then
          tag.a(notification.visitor.nickname, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
        when "favorite" then
          tag.a(notification.visitor.nickname, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:product_path(notification.product_id), style:"font-weight: bold;")+"にいいねしました"
        when "comment" then
            @comment = Comment.find_by(id: @visiter_comment)
            @messege = @comment.messege
            tag.a(@visiter.nickname, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:product_path(notification.product_id), style:"font-weight: bold;")+"にコメントしました"
      end
    end


end
