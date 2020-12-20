module NotificationsHelper

  def notification_form(notification)
      @visiter = notification.visiter
      #notification.actionがfollowかlikeか
      case notification.action
        when "follow" then
          tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
        when "like" then
          tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:recruitment_path(notification.recruitment_id), style:"font-weight: bold;")+"にいいねしました"
      end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end
