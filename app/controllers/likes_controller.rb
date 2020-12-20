class LikesController < ApplicationController
  before_action :authenticate_user!


  def create
    @like = current_user.likes.build(like_params)
    @recruitment = @like.recruitment
    @like.save
    recruitment = Recruitment.find(params[:recruitment_id])
    recruitment.create_notification_like!(current_user)
    respond_to :js
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
