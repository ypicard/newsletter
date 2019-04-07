# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/newsletter_mailer
class NewsletterMailerPreview < ActionMailer::Preview
  def weekly_newsletter_email
    NewsletterMailer.weekly_newsletter_email(Newsletter.first)
  end
end
