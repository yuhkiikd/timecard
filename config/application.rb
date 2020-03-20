require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module TimecardApp
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.load_defaults 5.2
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.assets.initialize_on_precompile = false
    config.action_view.field_error_proc = proc { |html_tag, instance| "<div class='has-error'>#{html_tag}</div>".html_safe }
    config.generators do |g|
      g.assets false
      g.helper false
      g.jbuilder false
      g.test_framework :rspec,
                        fixtures: true,
                        model_specs: true,
                        view_specs: false,
                        helper_specs: false,
                        routing_specs: false,
                        controller_specs: false,
                        request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
  end
end