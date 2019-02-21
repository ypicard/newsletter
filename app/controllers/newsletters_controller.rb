# frozen_string_literal: true

class NewslettersController < ApplicationController
  before_action :fetch_community

  def index; end

  def show
    @newsletter = @community.newsletters.where(id: params[:id]).first
  end

  def new
    @community = Community.where(id: params[:community_id]).first
    date = Date.today
    @newsletter = @community.generate_newsletter(Newsletter::WEEKLY, date.cweek, date.month, date.year)
  end

  def create
    @community = Community.where(id: params[:community_id]).first
    date = Date.today
    @newsletter = @community.generate_newsletter(Newsletter::WEEKLY, date.cweek, date.month, date.year)

    if @newsletter.save
      flash[:primary] = 'Newsletter created'
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
        flash[:primary] = 'Newsletter sent'
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
