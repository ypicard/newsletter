# frozen_string_literal: true

class NewsletterMailer < ApplicationMailer
  def weekly_newsletter_email(community, users, links)
    @community = community
    @links = links
    # TODO: say how many weekly digest there has already been in subject
    mail(to: users.map(&:email), subject: "#{@community.name} - weekly digest")
  end
end
