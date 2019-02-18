class NewslettersController < ApplicationController

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
            flash[:notice] = 'Newsletter created'
        else
            flash[:alert] = 'Something went wrong'
            render action: 'new'
        end
    end

    def send_email
        Newsletter.where(id: params[:id]).first.send_email
    end
end
