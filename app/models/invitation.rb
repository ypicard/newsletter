# frozen_string_literal: true

class Invitation < ApplicationRecord
  ACCEPTED = 'ACCEPTED'
  REJECTED = 'REJECTED'
  PENDING = 'PENDING'

  belongs_to :sender, class_name: :User
  belongs_to :user, optional: true
  belongs_to :community

  after_create :send_new_invitation_email

  def accept
    self.status = ACCEPTED
    user.communities << community
    save
  end

  def reject
    self.status = REJECTED
    save
  end

  private

  def send_new_invitation_email
    InvitationMailer.new_invitation_email(email, community).deliver_later
  end
end
