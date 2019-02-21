# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/invitation_mailer
class InvitationMailerPreview < ActionMailer::Preview
  def new_invitation_email
    InvitationMailer.new_invitation_email(Invitation.first)
    end
end
