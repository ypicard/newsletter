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

  def name
    community.name + ' newsletter #' + community.newsletters.count.to_s + ' (' + period + ' ' + week.to_s + ')'
  end

  def send_email
    ap 'TODO: SEND'
    self.delivered = true # TODO: if success
    NewsletterMailer.weekly_newsletter_email(community, users, links).deliver_later
  end
end
