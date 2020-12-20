class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:following_id])
    current_user.follow(@user)
    @user.create_notification_follow!(current_user)
    respond_to :js
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    respond_to :js
  end

end
