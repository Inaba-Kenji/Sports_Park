class RecruitmentsController < ApplicationController

  def new
    @recruitment = Recruitment.new
  end

  def index
    @recruitments = Recruitment.all
  end

  def show
  end

  def create
    @recruitment = Recruitment.new(recruitment_params)
    @recruitment.user_id = current_user.id
    @recruitment.save
    redirect_to recruitments_path
  end

  private

  def recruitment_params
    params.require(:recruitment).permit(:title, :event_date, :place, :price, :recruitment_introduction)
  end


end
