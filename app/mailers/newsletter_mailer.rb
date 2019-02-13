# frozen_string_literal: true

class NewsletterMailer < ApplicationMailer
  def weekly_email(community)
    @community = community
    # TODO: say how many weekly digest there has already been in subject
    # TODO: create newsletter model
    mail(to: community.users.map(&:email), subject: "#{@community.name} - weekly digest")
  end
end
