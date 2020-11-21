class RecruitmentsController < ApplicationController

  def new
    @recruitment = Recruitment.new
  end

  def index
    @recruitments = Recruitment.all
  end

  def show
    @recruitment = Recruitment.find(params[:id])

    # DM機能
    @userId = @recruitment.user.id

    @currentUserEntry = Entry.where(user_id: current_user.id)

    @userEntry = Entry.where(user_id: @userId)

    unless @userId == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def create
    @recruitment = Recruitment.new(recruitment_params)
    @recruitment.user_id = current_user.id
    @recruitment.save
    redirect_to recruitments_path
  end

  def destroy
    recruitment = Recruitment.find(params[:id])
    recruitment.destroy
    redirect_to recruitments_path
  end

  def edit
    @recruitment = Recruitment.find(params[:id])
  end

  def update
    @recruitment = Recruitment.find(params[:id])
    if @recruitment.update(recruitment_params)
      redirect_to recruitments_path
    else
      render :edit
    end
  end


  private

  def recruitment_params
    params.require(:recruitment).permit(:title, :event_date, :place, :price, :recruitment_introduction)
  end


end
