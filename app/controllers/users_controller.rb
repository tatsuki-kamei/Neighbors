class UsersController < ApplicationController
	before_action :authenticate_user!
	def show
		@user = User.find(params[:id])
		@parents = Category.where(ancestry: nil)
		@currentUserEntry=Entry.where(user_id: current_user.id)
	    @userEntry=Entry.where(user_id: @user.id)
	    if @user.id == current_user.id
	    else
	      @currentUserEntry.each do |cu|
	        @userEntry.each do |u|
	          if cu.room_id == u.room_id then
	            @isRoom = true
	            @roomId = cu.room_id
	          end
	        end
	      end
	      if @isRoom
	      else
	        @room = Room.new
	        @entry = Entry.new
	      end
	    end
	end

	def edit
		@user = User.find(params[:id])
		@user.user_categories.build
	end

	def update
		user = User.find(params[:id])
		if params[:user][:category] != nil
			params[:user][:category].each do |category|
				unless UserCategory.exists?(user_id:current_user.id,category_id: category)
					UserCategory.create(user_id:current_user.id,category_id: category)
				end
			end
		end
		user.update(user_params)
		redirect_to user_path(user)
	end

	private

	def user_params
		params.require(:user).permit(:nickname, :introduction, :image, user_categories_attributes:[:id,:user_id,:category_id])
	end
end
