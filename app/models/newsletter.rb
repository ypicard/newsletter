# frozen_string_literal: true

class Newsletter < ApplicationRecord
  WEEKLY = 'WEEKLY'
  PERIODS = [WEEKLY].freeze

  has_many :newsletter_users
  has_many :users, through: :newsletter_users
  has_many :newsletter_links
  has_many :links, through: :newsletter_links
  belongs_to :community

  validates :period, inclusion: { in: PERIODS }

  before_create :newsletter_is_unique

  def newsletter_is_unique
    if community.newsletters.where(period: period, week: week, month: month, year: year).any?
      errors.add(:this_newsletter, 'already exists')
      throw(:abort)
    end
  end

  def name
    community.name + ' newsletter (' + period + ' ' + week.to_s + ')'
  end

  def send_email
    NewsletterMailer.weekly_newsletter_email(community, users.to_a, links.to_a).deliver_later
    self.delivered = true
    save
    delivered
  end
end
