class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notifiable, polymorphic: true, touch: true

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }
end
