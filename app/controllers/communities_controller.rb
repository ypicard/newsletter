# frozen_string_literal: true

class CommunitiesController < ApplicationController
  before_action :fetch_community, except: %i[index new create]

  def index; end

  def show; end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    @community.creator = current_user
    @community.users << current_user
    if @community.save
      flash[:primary] = 'Community created: welcome !'
      render action: 'show'
    else
      flash[:warning] = 'Something went wrong'
      render action: 'new'
    end
  end

  def invitations
    render 'invitations'
  end

  def new_invitation
    @invitation = Invitation.new
  end

  def create_invitation
    @invitation = Invitation.new(sender: current_user, community: @community)

    handle = invitation_params[:handle]
    invitee = User.where(username: handle).or(User.where(email: handle)).first

    if invitee.nil?
      # If handle is an email
      if !(handle =~ URI::MailTo::EMAIL_REGEXP).nil?
        @invitation.email = handle
      else
        flash[:warning] = 'Username not found or invalid email'
        render 'new_invitation'
        return
      end
    else
      @invitation.user = invitee
      @invitation.email = invitee.email
    end

    if @invitation.save
      flash[:primary] = 'Invite sent'
      render 'invitations'
    else
      render 'new_invitation'
    end
  end

  def revoke_invitation
    invitation = @community.invitations.where(sender: current_user, id: params[:id]).first
    if invitation.nil?
      flash[:warning] = 'You do not have access to this invitation'
    else
      invitation.revoke
      invitation.save
      end
    render 'invitations'
  end

  def users;
  end

  private

  def fetch_community
    @community = current_user.communities.where(id: [params[:community_id], params[:id]]).first
    if @community.nil?
      flash[:warning] = 'You do not have access to this community'
      render :index
    end
  end

  def community_params
    params.require(:community).permit(:name)
  end

  def invitation_params
    params.require(:invitation).permit(:handle)
  end
end
