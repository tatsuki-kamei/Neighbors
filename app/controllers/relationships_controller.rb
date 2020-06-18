class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'follow success'
      @user.create_notification_follow!(current_user)
      redirect_to @user
    else
      flash.now[:alert] = 'follow failure'
      redirect_to @user
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'unfollow　success'
      redirect_to @user
    else
      flash.now[:alert] = 'unfollow failure'
      redirect_to @user
    end
  end

  private
  def set_user
    @user = User.find(params[:follow_id])
  end

end
