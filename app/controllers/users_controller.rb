class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :forbid_test_user, {only: [:edit,:update,:destroy]}
	def show
		@user = User.find(params[:id])
		@parents = Category.where(ancestry: nil)
		@currentUserEntry=Entry.where(user_id: current_user.id)
	    @userEntry=Entry.where(user_id: @user.id)
	    @chart = @user.products
	    unless @user.id == current_user.id
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
		if @user = current_user
			@user.user_categories.build
			@parents = Category.where(ancestry: nil)
		else
			redirect_to user_path(@user)
		end
	end

	def update
		user = User.find(params[:id])
		user.update(user_params)
		redirect_to user_path(user)
	end

	def index
		@users = User.all
	end

	private

	def user_params
		params.require(:user).permit(:nickname, :introduction, :image, user_categories_attributes:[:id,:user_id,:category_id])
	end

	def forbid_test_user
	  if params[:email] == "test@example.com"
	    flash[:notice] = "テストユーザーのため変更できません"
	    redirect_to root_path
	  end
	end
end
