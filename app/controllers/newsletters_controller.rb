class NewslettersController < ApplicationController

    before_action :fetch_community

    def index
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
            flash[:warning] = 'Something went wrong'
            render action: 'new'
        end
    end

    def send_email
        Newsletter.where(id: params[:id]).first.send_email
    end

    private 

    def fetch_community
        @community = current_user.communities.where(id: params[:community_id]).first
        if @community.nil?
            flash[:warning] = "You do not have access to this community"
            redirect_back(fallback_location: root_path)
        end
    end
end
