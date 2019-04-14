# frozen_string_literal: true

class NewslettersController < ApplicationController
  before_action :fetch_community

  def index; end

  def show
    @newsletter = @community.newsletters.where(id: params[:id]).first
  end

  def new
    @community = Community.where(id: params[:community_id]).first
    @newsletter = @community.generate_and_update_newsletter_for_current_week
  end

  def create
    @community = Community.where(id: params[:community_id]).first
    @newsletter = @community.generate_and_update_newsletter_for_current_week

    if @newsletter.save
      flash[:success] = 'Newsletter created'
    else
      flash[:warning] = @newsletter.errors.full_messages
      render :new
    end
  end

  def send_email
    newsletter = Newsletter.where(id: params[:id]).first
    if newsletter.delivered
      flash[:warning] = 'Newsletter already sent'
    else
      newsletter.send_email
      if newsletter.save
        flash[:success] = 'Newsletter sent'
      else
        flash[:warning] = newsletter.errors.full_messages
      end
    end
    render :index
  end

  private

  def fetch_community
    @community = current_user.communities.where(id: params[:community_id]).first
    if @community.nil?
      flash[:warning] = 'You do not have access to this community'
      redirect_back(fallback_location: root_path)
    end
  end

end
