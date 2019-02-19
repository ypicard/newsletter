# frozen_string_literal: true

class InvitationsController < ApplicationController

  def index
  end

  def accept
    current_user.invitations.where(id: params[:id]).first.accept
    redirect_back(fallback_location: root_path)
  end

  def reject
    current_user.invitations.where(id: params[:id]).first.reject
    redirect_back(fallback_location: root_path)
  end

end
