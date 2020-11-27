class RecruitmentsController < ApplicationController

  def new
    @recruitment = Recruitment.new
  end

  def index
    @recruitments = Recruitment.all.page(params[:page]).per(6)
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

  def search
    place_area_ids = Recruitment.where("place_area LIKE (?)", "#{params[:place_area]}").pluck(:id)
    sports_genre_ids = Recruitment.where("sports_genre LIKE (?)", "#{params[:sports_genre]}").pluck(:id)
    @result_searched = Recruitment.where("id IN (?) or id IN (?)", place_area_ids, sports_genre_ids).page(params[:page]).per(6)
  end

  def text_search
    @recruitments = Recruitment.all.search(params[:search]).page(params[:page]).per(5)
  end


  private

  def recruitment_params
    params.require(:recruitment).permit(:title, :event_date, :place, :price, :recruitment_introduction, :place_area, :sports_genre)
  end


end
