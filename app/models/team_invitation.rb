class TeamInvitation < ActiveRecord::Base
  has_secure_token

  belongs_to :team

  scope :accepted, -> { where(accepted: true) }
  scope :not_accepted, -> { where(accepted: false) }

end
