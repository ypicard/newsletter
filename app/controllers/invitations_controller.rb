# frozen_string_literal: true

class InvitationsController < ApplicationController
  def index
    @community = Community.where(id: params[:community_id]).first
    @invitations = @community.invitations
  end

  def new
    @community = Community.where(id: params[:community_id]).first
    @invitation = Invitation.new
  end

  def create
    @community = Community.where(id: params[:community_id]).first
    @invitation = Invitation.new(invitation_params.merge(sender: current_user,
                                                         community: @community,
                                                         token: SecureRandom.uuid))

    # Require at least email or username
    if invitation_params[:username].blank? && invitation_params[:email].blank?
      flash[:alert] = 'One or other is required'
      render 'new'
      return
    end

    # If username
    if invitation_params[:username].present?
      invitee = User.where(username: invitation_params[:username]).first
      # If username, must fit to existing user
      if invitee.nil?
        flash[:alert] = 'Username does not exist'
        render 'new'
        return
      end
    else
      # If email
      invitee = User.where(email: invitation_params[:email]).first
      # todo: if invitee exist, invite him in app, else send an email to create new account
    end

    @invitation.user = invitee

    if @invitation.save
      flash[:notice] = 'Invite sent'
    else
      render 'new'
    end
  end

  def accept
    current_user.invitations.where(id: params[:id]).first.accept
    redirect_back(fallback_location: root_path)
  end

  def reject
    current_user.invitations.where(id: params[:id]).first.reject
    redirect_back(fallback_location: root_path)
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :username)
  end
end
