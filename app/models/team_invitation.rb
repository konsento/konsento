class TeamInvitation < ApplicationRecord
  has_secure_token

  belongs_to :team

  validates :email, email: {strict_mode: true}, uniqueness: {
    scope: :team
  }

  validate :email_cannot_be_subscribed, on: :create
  validates :team, presence: true
  validates :token, presence: true
  validates :accepted, inclusion: {in: [true, false]}

  scope :accepted, -> { where(accepted: true) }
  scope :not_accepted, -> { where(accepted: false) }

  after_create { |team_invitation| Notification.notify(team_invitation) }

  def self.invite_emails(emails, team, user)
    emails = emails.split(',') unless emails.respond_to? :to_ary
    emails = emails.map(&:strip)
    team_invitations = []

    emails.each do |email|
      ActiveRecord::Base.transaction do
        unless User.find_by(email: email)
          unless Invitation.invite_emails(email, user)
            raise ActiveRecord::Rollback, "Invitation not created"
          end
        end
        team_invitations << create_team_invitation(email, team)
      end
    end

    team_invitations
  end

  def send_email
    TeamInvitationMailer.invite(self).deliver_later
  end

  def email_cannot_be_subscribed
    user = User.find_by(email: email)
    if Subscription.find_by(subscriptable: team, user: user)
      errors.add(:email, 'Email already subscribed')
    end
  end

  private
  def self.create_team_invitation(email, team)
    team_invitation = team.team_invitations.create(
      email: email,
      accepted: false,
      token: SecureRandom.hex
    )

    team_invitation.send_email if team_invitation.persisted?

    team_invitation
  end
end
