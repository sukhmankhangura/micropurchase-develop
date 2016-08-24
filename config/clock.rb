require "clockwork"
require_relative "boot"
require_relative "environment"

module Clockwork
  # disabled until https://github.com/18F/micropurchase/issues/951 is fixed
  # every(1.day, "tock_projects.import", at: "02:00", tz: 'Eastern Time (US & Canada)') do
  # puts "Importing Tock projects"
  # TockImporter.new.delay.perform
  # end

  every(1.day, "insight_metrics.update", at: "02:00", tz: 'Eastern Time (US & Canada)') do
    puts "Updating insight metrics"
    UpdateInsighMetrics.new.delay.perform
  end
end
