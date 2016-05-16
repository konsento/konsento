class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notifiable, polymorphic: true, touch: true

  validates :user, :key, :data, :notifiable, presence: true
  validates :read, inclusion: {in: [true, false]}

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }

  def self.notify(notifiable)
    self.send("notify_#{notifiable.model_name.element}", notifiable)
  end

  private
  def self.notify_comment(comment)
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
    users.uniq!

    puts "\n\n\n\n #{users} \n\n\n\n"

    users.each do |user_id|
      Notification.create(
        user_id: user_id,
        key: key,
        data: data,
        notifiable: comment,
        read: false
      )
    end
  end

  def self.notify_team_invitation(team_invitation)
    key = 'team_invitation'
    data = { 'team_title' => team_invitation.team.title }
    user = User.find_by(email: team_invitation.email)
    if user
      Notification.create(
        user_id: user.id,
        key: key,
        data: data,
        notifiable: team_invitation
      )
    end
  end

  def self.notify_topic(topic)
    key = 'new_topic'
    data = { 'location_title' => topic.location.title }
    users = topic.location.users.pluck(:id)
    users.delete(topic.user_id)

    users.each do |user_id|
      Notification.create(
        user_id: user_id,
        key: key,
        data: data,
        notifiable: topic
      )
    end
  end
end
