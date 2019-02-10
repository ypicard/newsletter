# frozen_string_literal: true

class Community < ApplicationRecord
  validates :name, uniqueness: true, presence: true, allow_blank: false

  has_many :memberships
  has_many :users, through: :memberships
  has_many :invitations
  has_many :links

  belongs_to :creator, class_name: :User # todo: should be in memberships table as a role
end
