class FavoritesController < ApplicationController
	before_action :authenticate_user!
	def create
	    @product = Product.find(params[:product_id])
	    unless @product.like?(current_user)
	      @product.like(current_user)
	      @product.reload
	      @product.create_notification_like!(current_user)
	      respond_to do |format|
	        format.html { redirect_to request.referrer || root_url }
	        format.js
	      end
	    end
	 end

	def destroy
	    @product = Favorite.find(params[:id]).product
	    if @product.like?(current_user)
	    	notification = Notification.find_by(visitor_id: current_user.id, visited_id: @product.user_id, product_id: @product.id, action: "favorite")
	    	notification.destroy
	      @product.unlike(current_user)
	      @product.reload
	      respond_to do |format|
	        format.html { redirect_to request.referrer || root_url }
	        format.js
	      end
	    end
	end
end
