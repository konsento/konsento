module NotificationsHelper

  def classes_for_notification(notification_read_was)
    if notification_read_was
      classes = 'list-group-item'
    else
      classes = 'list-group-item unread'
    end
  end

  def icon_class_for_notification(notification)
    case notification.notifiable_type
    when 'Comment'
      icon_class = 'fa-comment-o'
    when 'Topic'
      icon_class = 'fa-list'
    when 'TeamInvitation'
      icon_class = 'fa-send-o'
    else
      icon_class = 'fa-circle-o'
    end

    icon_class
  end

  def message_for_notification(notification)
    case notification.notifiable_type
    when 'Comment'
      message = t 'notification_messages.' + notification.key + '_html', topic_title: notification.data['topic_title']
    when 'Topic'
      message = t 'notification_messages.' + notification.key + '_html', location_title: notification.data['location_title']
    when 'TeamInvitation'
      message = t 'notification_messages.' + notification.key + '_html', team_title: notification.data['team_title']
    else
      message = t 'notification_messages.' + notification.key + '_html'
    end

    message
  end

  def link_for_notification(notification)
    if notification.notifiable
      case notification.notifiable_type
      when 'Comment'
        case notification.notifiable.commentable_type
        when 'Topic'
          link = topic_path(notification.notifiable.commentable)
        when 'Proposal'
          link = proposal_path(notification.notifiable.commentable)
        end
      when 'Topic'
        link = topic_path(notification.notifiable)
      when 'TeamInvitation'
        if notification.notifiable.accepted
          link = teams_path
        else
          link = accept_team_invitations_path(notification.notifiable.token)
        end
      end
    else
      link = unavailable_content_path
    end
    link
  end
end
