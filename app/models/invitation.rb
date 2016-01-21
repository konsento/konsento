class Invitation < ActiveRecord::Base
  has_secure_token

  belongs_to :user, inverse_of: :invitations, required: true

  validates :email, email: {strict_mode: true}, uniqueness: {
    scope: :user,
    case_sensitive: false
  }

  validate :email_available

  scope :registered, -> { where(registered: true) }
  scope :not_registered, -> { where(registered: false) }

  def self.invite_emails(emails, user)
    emails = emails.split(',') unless emails.respond_to? :to_ary
    emails = emails.map(&:strip)

    return false unless user.available_invitations.to_i >= emails.size

    invitations = emails.map { |email| user.invitations.create(email: email) }

    invitations.each do |i|
      if i.persisted?
        user.decrement!(:available_invitations)
        i.send_email
      end
    end

    invitations
  end

  def send_email
    InvitationMailer.invite(self).deliver_now
  end

  private

  def email_available
    if User.exists?(email: email)
      errors.add(:email, 'Já há um usuário registrado com esse email')
    end
  end
end
