require_relative '../../lib/conditional_asset_compressor'

Rails.application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: ENV['SMTP_DOMAIN'] || 'gmail.com',
    user_name: SMTPCredentials.smtp_username,
    password: SMTPCredentials.smtp_password,
    authentication: 'plain',
    enable_starttls_auto: true
  }
  config.action_mailer.default_url_options = { host: SMTPCredentials.default_url_host }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true

  config.action_controller.perform_caching = true
  config.active_record.dump_schema_after_migration = false
  config.active_support.deprecation = :notify
  config.assets.compile = false
  config.assets.digest = true
  config.assets.js_compressor = ConditionalAssetCompressor.new
  config.cache_classes = true
  config.consider_all_requests_local = false
  config.eager_load = true
  config.force_ssl = false
  config.i18n.fallbacks = true
  config.log_formatter = ::Logger::Formatter.new
  config.log_level = :debug
  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?
end
