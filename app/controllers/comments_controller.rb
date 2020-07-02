class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    comment = current_user.comments.new(comment_params)
    rate = params[:product_comment][:rate]
    #product = Product.find_by(id: comment.product_id)
    #comment.product_id = product.id
    user_comment = Comment.find_by(user_id: current_user.id, product_id: @product.id)
    if  user_comment.present?
      score = Language.get_data(comment_params[:messege])
      user_comment.update(title: comment.title, messege: comment.messege, rate: rate, score: score)
    else
      comment.product_id = @product.id
      comment.rate = rate
      comment.score = Language.get_data(comment_params[:messege])
      comment.save(comment_params)
      @product.create_notification_comment!(current_user, comment.id)
    end
    @product.update(rate: @product.comments.average(:rate))
    redirect_to product_path(@product)
  end

  def destroy
    comment = Comment.find(params[:id])
    @product = comment.product
    comment.destroy
    redirect_to product_path(@product)
  end

  private
  def comment_params
      params.require(:comment).permit(:messege, :title, :rate)
  end

end