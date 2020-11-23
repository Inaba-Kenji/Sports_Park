class UsersController < ApplicationController

  #ユーザーの一覧
  def index
    @users = User.all
  end

  #ユーザーの詳細
  def show
    @user = User.find(params[:id])
    @following_users = @user.following
    @followers_users = @user.followers
  end

  #マイページの詳細
  def mypage_show
  end

  #マイページの編集画面
  def mypage_edit
  end

  #マイページの編集の保存
  def mypage_update
    if current_user.update(user_params)
      redirect_to mypage_show_user_path
    else
      render "mypage_edit"
    end
  end

  #退会ボタン押下時
  def quit
  end

  #退会画面の表示
  def out
  end

  private

   def user_params
      params.require(:user).permit(:profile_image, :name, :email, :postal_code, :address, :gender, :age, :favorites_sports, :introduction)
   end


end
