class HomesController < ApplicationController
  def top
  end

  def about
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストログイン"
      user.postal_code = "999999"
      user.address = "ゲストログイン"
      user.gender = "回答しない"
      user.age = "回答しない"
      user.favorites_sports = "フットサル"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to recruitments_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
