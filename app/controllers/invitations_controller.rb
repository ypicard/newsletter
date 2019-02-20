# frozen_string_literal: true

class InvitationsController < ApplicationController

  def index
  end

  def accept
    invitation = current_user.invitations.where(id: params[:id]).first
    invitation.accept
    invitation.save
    redirect_back(fallback_location: root_path)
  end

  def reject
    invitation = current_user.invitations.where(id: params[:id]).first
    invitation.reject
    invitation.save
    redirect_back(fallback_location: root_path)
  end

  def revoke
    invitation = Invitation.where(id: params[:id]).first
    invitation.revoke
    invitation.save
    redirect_back(fallback_location: root_path)
  end

end
