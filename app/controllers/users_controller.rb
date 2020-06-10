class UsersController < ApplicationController
	before_action :authenticate_user!
	def show
		@user = User.find(params[:id])
		@parents = Category.where(ancestry: nil)
	end

	def edit
		@user = User.find(params[:id])
		@user.user_categories.build
	end

	def update
		user = User.find(params[:id])
		params[:user][:category].each do |category|
			unless UserCategory.exists?(user_id:current_user.id,category_id: category)
				UserCategory.create(user_id:current_user.id,category_id: category)
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
