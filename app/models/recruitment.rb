class Recruitment < ApplicationRecord

  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :user

  #いいね 機能
  def liked_by(user)
    Like.find_by(user_id: user.id, recruitment_id: id)
  end

  # 検索機能
  def self.search(search)
    search ? where('title LIKE ?', "%#{search}%") : all
  end

  # 通知機能
  def create_notification_by(current_user)
        notification = current_user.active_notifications.new(
          item_id: id,
          visited_id: user_id,
          action: "like"
        )
        notification.save if notification.valid?
  end


end
