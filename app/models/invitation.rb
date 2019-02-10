# frozen_string_literal: true

class Invitation < ApplicationRecord
  ACCEPTED = 'ACCEPTED'
  REJECTED = 'REJECTED'
  PENDING = 'PENDING'

  belongs_to :sender, class_name: :User
  belongs_to :user, optional: true
  belongs_to :community

  def accept
    self.status = ACCEPTED
    user.communities << community
    save
  end

  def reject
    self.status = REJECTED
    save
  end
end
