# frozen_string_literal: true

namespace :newsletters do
  desc 'Generate and send weekly newsletters'
  task generate_and_send_weekly: :environment do
    Rake::Task['newsletters:generate_weekly'].invoke
    Rake::Task['newsletters:send_weekly'].invoke
  end

  desc 'Generate and update weekly newsletters'
  task generate_weekly: :environment do
    Rails.logger.info 'Generating newsletters for current week...'
    nb_pending = Community.all.map(&:generate_and_update_newsletter_for_current_week).compact.count
    Rails.logger.info "Done: #{nb_pending} pending newsletters"
  end

  desc 'Send weekly newsletters'
  task send_weekly: :environment do
    Rails.logger.info 'Sending newsletters for current week...'
    nb_sent = Newsletter.where(delivered: false).map(&:send_email).count
    Rails.logger.info "Done: #{nb_sent} newsletters sent"
  end
end
