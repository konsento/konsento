class Reference < ApplicationRecord
  belongs_to :user
  belongs_to :proposal

  validates :user, :content, presence: true

end
