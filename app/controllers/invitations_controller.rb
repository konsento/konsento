class InvitationsController < ApplicationController
  before_action :require_login, except: [:registration_form, :register]

  def index
    @invitations = current_user.invitations.order(:registered, :email)
    add_breadcrumb Invitation.model_name.human(count: 2)
  end

  def create
    Invitation.invite_emails(invitation_params[:email], current_user)
    redirect_to invitations_path
  end

  def send_email
    scope.find(params[:id]).send_email
    redirect_to invitations_path
  end

  def registration_form
    @invitation = Invitation.not_registered.find_by!(token: params[:token])
    @user = User.new(email: @invitation.email)
  end

  def register
    @invitation = Invitation.not_registered.find_by!(token: params[:token])

    @user = User.create(user_params) do |u|
      u.email = @invitation.email
    end

    if @user.valid?
      @invitation.update_attribute(:registered, true)
      redirect_to sign_in_path
    else
      render :registration_form
    end
  end

  private

  def scope
    current_user.invitations.not_registered
  end

  def invitation_params
    params.require(:invitation).permit(:email)
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
