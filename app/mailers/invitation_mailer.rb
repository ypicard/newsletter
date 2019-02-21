# frozen_string_literal: true

class InvitationMailer < ApplicationMailer
  def new_invitation_email(invitation)
    @invitation = invitation
    mail(to: @invitation.email, subject: "You've been invited to the #{@invitation.community.name} community")
  end
end
