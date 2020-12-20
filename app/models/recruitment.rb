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
  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visiter_id = ? and visited_id = ? and recruitment_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        recruitment_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

end
