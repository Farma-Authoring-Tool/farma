require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Farma
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = ['pt-BR']
    config.i18n.default_locale = :'pt-BR'
    config.time_zone = 'America/Sao_Paulo'

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.autoload_paths += Rails.root.glob('app/resources/**')

    config.active_support.to_time_preserves_timezone = :zone

    # When both `If-Modified-Since` and `If-None-Match` are provided by the client
    # only consider `If-None-Match` as specified by RFC 7232 Section 6.
    # If set to `false` both conditions need to be satisfied.
    config.action_dispatch.strict_freshness = true

    ###
    # Set `Regexp.timeout` to `1`s by default to improve security over Regexp Denial-of-Service attacks.
    #++
    Regexp.timeout = 1
  end
end
