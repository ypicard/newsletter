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
      flash[:success] = 'Community created: welcome !'
      redirect_to action: :show, id: @community.id
    else
      flash[:warning] = 'Something went wrong'
      render 'new'
    end
  end

  def invitations; end

  # def new_invitation
  #   @invitation = Invitation.new
  # end

  def create_invitation
    invitation = Invitation.new(sender: current_user, community: @community)

    handle = invitation_params[:handle]
    invitee = User.where(username: handle).or(User.where(email: handle)).first

    if invitee.nil?
      # If handle is an email
      if !(handle =~ URI::MailTo::EMAIL_REGEXP).nil?
        invitation.email = handle
      else
        flash[:warning] = 'Username not found or invalid email'
      end
    else
      # invitee not nil
      if !@community.users.include?(invitee)
        invitation.user = invitee
        invitation.email = invitee.email
        flash[:success] = 'Invite sent' if invitation.save
      else
        flash[:warning] = "#{invitee.username} is already a member of this community"
      end
    end

    redirect_to :community_invitations
  end

  def revoke_invitation
    invitation = @community.invitations.where(sender: current_user, id: params[:id]).first
    if invitation.nil?
      flash[:warning] = 'You do not have access to this invitation'
    else
      invitation.revoke
      invitation.save
      end

    redirect_to :community_invitations
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
