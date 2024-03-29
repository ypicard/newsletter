# frozen_string_literal: true

class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true, allow_blank: false
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_create :update_invitations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships
  has_many :communities, -> { distinct }, through: :memberships
  has_many :invitations
  has_many :links

  attr_accessor :invitation_token

  private

  # Link token based invitations to user after creation
  def update_invitations
    # user: nil is here to make sure invitations are linked only once
    invitations << Invitation.where(token: invitation_token, user: nil)
  end
end