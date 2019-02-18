# Preview all emails at http://localhost:3000/rails/mailers/newsletter_mailer
class NewsletterMailerPreview < ActionMailer::Preview

  def weekly_newsletter_email
    date = Date.today
    newsletter = Community.first.generate_newsletter(Newsletter::WEEKLY, date.cweek, date.month, date.year)
    NewsletterMailer.weekly_newsletter_email(newsletter.community, newsletter.users, newsletter.links)
  end

end
