# frozen_string_literal: true

class Community < ApplicationRecord
  validates :name, uniqueness: true, presence: true, allow_blank: false

  has_many :memberships
  has_many :users, -> { distinct }, through: :memberships
  has_many :invitations
  has_many :links
  has_many :newsletters

  belongs_to :creator, class_name: :User # todo: should be in memberships table as a role


  # Generate a newsletter and send it
  def generate_newsletter(period, week, month, year)
    newsletter = Newsletter.new(period: period,
                                week: week,
                                month: month,
                                year: year,
                                community: self,
                                users: users,
                                links: get_links(period, week, month, year))
  end

  private

  # Return link digest given a period, and date information
  def get_links(period, week, month, year)
    case period
    when Newsletter::WEEKLY
      date = Date.commercial(year, week)
      links.where(created_at: [date.at_beginning_of_week..date.at_end_of_week])
    end
  end
end
