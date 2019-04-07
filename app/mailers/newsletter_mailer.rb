# frozen_string_literal: true

class NewsletterMailer < ApplicationMailer
  def weekly_newsletter_email(newsletter)
    @community = newsletter.community
    @links = newsletter.links
    mail(to: newsletter.users.map(&:email), subject: newsletter.name)
  end
end
