# frozen_string_literal: true

class InvitationsController < ApplicationController
  before_action :fetch_invitation, except: [:index]

  def index; end

  def accept
    @invitation.accept
    @invitation.save
    redirect_back(fallback_location: root_path)
  end

  def reject
    @invitation.reject
    @invitation.save
    redirect_back(fallback_location: root_path)
  end

  private

  def fetch_invitation
    @invitation = Invitation.where(user: current_user, id: params[:id]).where.not(status: Invitation::REVOKED).first
    if @invitation.nil?
      flash[:warning] = 'You do not have access to this invitation'
      redirect_back(fallback_location: root_path)
    end
  end
end
