# frozen_string_literal: true

namespace :heroku do
  desc 'Send weekly newsletters on sunday'
  task sunday_newsletters: :environment do
    exit unless Date.today.sunday?

    Rake::Task['newsletters:generate_and_send_weekly'].invoke
  end
end
