# frozen_string_literal: true

class LinksController < ApplicationController
  def new
    @community = Community.where(id: params[:community_id]).first
    @link = Link.new
  end

  def create
    @community = Community.where(id: params[:community_id]).first

    @link = Link.new(link_params.merge(user: current_user, community: @community))

    if @link.save
      render 'create'
    else
      render 'new'
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
