class LikesController < ApplicationController
  before_action :authenticate_user!


  def create
    @like = current_user.likes.build(like_params)
    @like.save
    @recruitment = @like.recruitment
    # 通知機能の作成
    @recruitment.create_notification_by(current_user)
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
  end


  def destroy
    @like = Like.find_by(id: params[:id])
    @recruitment = @like.recruitment
    if @like.destroy
      respond_to :js
    end
  end

  private

    def like_params
      params.permit(:recruitment_id)
    end

end
