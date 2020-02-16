require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module TimecardApp
  class Application < Rails::Application
    config.load_defaults 5.2
    I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    I18n.locale = :ja
    I18n.default_locale = :ja
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.locale = :ja
    config.assets.initialize_on_precompile = false
    config.time_zone = 'Tokyo'
    config.generators do |g|
      g.assets false
      g.helper false
      g.jbuilder false
      g.test_framework :rspec,
                        model_specs: true,
                        view_specs: false,
                        helper_specs: false,
                        routing_specs: false,
                        controller_specs: false,
                        request_specs: false
    end

    config.active_record.default_timezone = :local
    config.i18n.locale = :ja
    config.i18n.default_locale = :ja
  end
end