# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/invitation_mailer
class InvitationMailerPreview < ActionMailer::Preview
  def invitation
    InvitationMailer.new_invitation_email(User.first.email, Community.first)
  end
end
