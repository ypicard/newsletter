# frozen_string_literal: true

class LinksController < ApplicationController

  before_action :fetch_community

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params.merge(user: current_user, community: @community))

    if @link.save
      flash[:success] = 'Link published'
      redirect_to community_url(@community)
      # redirect_to controller: :community, action: :show
    else
      render 'new'
    end
  end

  private

  def fetch_community
    @community = current_user.communities.where(id: params[:community_id]).first
    if @community.nil?
      flash[:warning] = 'You do not have access to this community'
      redirect_back(fallback_location: root_path)
    end
  end

  def link_params
    params.require(:link).permit(:url)
  end
end
