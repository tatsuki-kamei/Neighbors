class UsersController < ApplicationController
	before_action :authenticate_user!
	def show
		@user = User.find(params[:id])
		@parents = Category.where(ancestry: nil)
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		user = user.find(params[:id])
		user.update
	end

	private

	def user_params
		params.require(:user).permit(:nickname, :introduction, :image)
	end
end
