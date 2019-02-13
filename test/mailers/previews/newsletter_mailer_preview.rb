# Preview all emails at http://localhost:3000/rails/mailers/newsletter_mailer
class NewsletterMailerPreview < ActionMailer::Preview
def weekly_email
    NewsletterMailer.weekly_email(Community.first)
  end
end
