# frozen_string_literal: true

class CommunitiesController < ApplicationController
  def index; end

  def show
    @community = Community.where(id: params[:id]).first
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    @community.creator = current_user
    @community.users << current_user
    if @community.save
      flash[:primary] = 'Community created'
    else
      flash[:warning] = 'Something went wrong'
      render action: 'new'
    end
  end

  def invitations
    @community = Community.where(id: params[:community_id]).first
    render 'invitations'
  end

  def create_invitation
    @community = Community.where(id: params[:community_id]).first
    @invitation = Invitation.new(sender: current_user, community: @community)
    
    handle = invitation_params[:handle]
    invitee = User.where(username: handle).or(User.where(email: handle)).first

    if invitee.nil?
      # If handle is an email
      if  !(handle =~ URI::MailTo::EMAIL_REGEXP).nil?
        @invitation.email = handle
      else 
        flash[:warning] = 'Username not found or invalid email'
        render 'invitations'
        return
      end
    else 
      @invitation.user = invitee
      @invitation.email = invitee.email
    end

    if @invitation.save
      flash[:primary] = 'Invite sent'
    end
    render 'invitations'

  end

  private

  def community_params
    params.require(:community).permit(:name)
  end

  def invitation_params
    params.require(:invitation).permit(:handle)
  end
end
