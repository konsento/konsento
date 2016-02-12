class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    case comment.commentable_type
    when 'Topic'
      key = 'new_topic_comment'
      data = {
        'topic_title' => comment.commentable.title
      }
    when 'Proposal'
      key = 'new_proposal_comment'
      data = {
        'topic_title' => comment.commentable.topic.title
      }
    end

    users = comment.commentable.comments.group(:user_id).pluck(:user_id)
    users << comment.commentable.user_id
    users.delete(comment.user_id)

    users.each do |user_id|
      Notification.create(
        user_id: user_id,
        key: key,
        data: data,
        notifiable: comment
      )
    end
  end
end
