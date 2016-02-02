class TeamInvitation < ActiveRecord::Base
  has_secure_token

  belongs_to :team

  validates :email, email: {strict_mode: true}, uniqueness: {
    scope: :team
  }

  validate :email_available

  scope :accepted, -> { where(accepted: true) }
  scope :not_accepted, -> { where(accepted: false) }

  def self.invite_emails(emails, team)
    emails = emails.split(',') unless emails.respond_to? :to_ary
    emails = emails.map(&:strip)

    team_invitations = emails.map do |email|
      team.team_invitations.create(email: email)
    end

    team_invitations.each do |i|
      if i.persisted?
        i.send_email
      end
    end

    team_invitations
  end

  def send_email
      TeamInvitationMailer.invite(self).deliver_later
  end

  def email_available
    unless User.exists?(email: email)
      errors.add(:email, 'Usuário não existe')
    end
  end
end
