# Preview all emails at http://localhost:3000/rails/mailers/newsletter_mailer
class NewsletterMailerPreview < ActionMailer::Preview
def weekly_newsletter_email
    NewsletterMailer.weekly_newsletter_email(Community.first, Community.first.users, Community.first.links)
end
end
