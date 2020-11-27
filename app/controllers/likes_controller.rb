class LikesController < ApplicationController
  before_action :authenticate_user!


  def create
    @like = current_user.likes.build(like_params)
    @recruitment = @like.recruitment
    if @like.save
      respond_to :js
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
