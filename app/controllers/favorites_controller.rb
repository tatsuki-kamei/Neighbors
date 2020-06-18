class FavoritesController < ApplicationController
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
	      @product.unlike(current_user)
	      @product.reload
	      respond_to do |format|
	        format.html { redirect_to request.referrer || root_url }
	        format.js
	      end
	    end
	end
end
