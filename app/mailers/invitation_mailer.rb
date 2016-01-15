class InvitationMailer < ApplicationMailer
  def invite(invitation)
    @invitation = invitation
    mail(to: @invitation.email, subject: "#{@invitation.user.username} te convidou para conhecer o Konsento!")
  end
end
