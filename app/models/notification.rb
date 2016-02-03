class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notifiable, polymorphic: true, touch: true
end
