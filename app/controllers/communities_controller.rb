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
      flash[:notice] = 'Community created'
    else
      flash[:alert] = 'Something went wrong'
      render action: 'new'
    end
  end

  private

  def community_params
    params.require(:community).permit(:name)
  end
end
