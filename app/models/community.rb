# frozen_string_literal: true

class Community < ApplicationRecord
  validates :name, uniqueness: true, presence: true, allow_blank: false

  has_many :memberships
  has_many :users, -> { distinct }, through: :memberships
  has_many :invitations
  has_many :links
  has_many :newsletters

  belongs_to :creator, class_name: :User # TODO: should be in memberships table as a role

  # Generate current week's newsletter
  def generate_and_update_newsletter_for_current_week
    date = Date.today
    generate_and_update_newsletter(Newsletter::WEEKLY, date.cweek, date.month, date.year)
  end

  private

  # Generate or update a newsletter newsletter and send it
  def generate_and_update_newsletter(period, week, month, year)
    newsletter = Newsletter.where(period: period,
                                  week: week, month: month, year: year,
                                  community: self).first

    return if newsletter.delivered?

    if newsletter.nil?
      newsletter = Newsletter.new(period: period,
                                  week: week, month: month, year: year,
                                  community: self)
     end

    newsletter.update_attributes!(
      users: users,
      links: get_links(period, week, month, year)
    )

    newsletter
  end

  # Return link digest given a period, and date information
  def get_links(period, week, _month, year)
    case period
    when Newsletter::WEEKLY
      date = Date.commercial(year, week)
      links.where(created_at: [date.at_beginning_of_week..date.at_end_of_week])
    end
  end
end
