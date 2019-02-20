# frozen_string_literal: true

class Invitation < ApplicationRecord
  ACCEPTED = 'ACCEPTED'
  REJECTED = 'REJECTED'
  PENDING = 'PENDING'
  REVOKED = 'REVOKED'

  belongs_to :sender, class_name: :User
  belongs_to :user, optional: true
  belongs_to :community

  attr_accessor :handle

  before_create :generate_token
  after_create :send_new_invitation_email

  def accept
    self.status = ACCEPTED
    user.communities << community
  end

  def reject
    self.status = REJECTED
  end

  def revoke
    self.status = REVOKED
  end

  def pending?
    status.eql?(PENDING)
  end

  def accepted?
    status.eql?(ACCEPTED)
  end

  def rejected?
    status.eql?(REJECTED)
  end

  def revoked?
    status.eql?(REVOKED)
  end

  private

  def send_new_invitation_email
    InvitationMailer.new_invitation_email(email, community).deliver_later
  end

  def generate_token
    self.token = SecureRandom.uuid
  end
end
