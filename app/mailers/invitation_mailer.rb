# frozen_string_literal: true

class InvitationMailer < ApplicationMailer
  def new_invitation_email(email, community)
    @community = community
    mail(to: email, subject: "You've been invited to the #{community.name} community")
  end
end
