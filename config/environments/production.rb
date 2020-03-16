Rails.application.configure do
  require 'base64'
  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false

  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.js_compressor = :uglifier

  config.assets.compile = true

  config.active_storage.service = :local

  config.log_level = :info

  config.log_tags = [ :request_id ]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
  config.action_mailer.default_url_options = { host: '13.114.47.119' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:"smtp.gmail.com",
    domain: 'gmail.com',
    port:587,
    user_name: Rails.application.credentials.gmail[:user_name],
    password: Rails.application.credentials.gmail[:password],
    authentication: :login
  }
end