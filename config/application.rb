require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UponArrival
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Enable serving of images, stylesheets, and JavaScripts from an asset server.
    if ENV['ASSET_HOST']
      config.action_controller.asset_host = ENV['ASSET_HOST']
      config.action_mailer.asset_host = ENV['ASSET_HOST']
    end

    # Don't generate to much scaffolding.
    config.generators do |g|
      g.helper false
      g.assets false
      g.helper false
      g.view_specs false
      g.decorator false
    end

    if ENV['REDIS_URL']
      config.redis = { url: ENV['REDIS_URL'] }
      config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }
    end

    # Let us break our I18n into lots of smaller files.
    config.i18n.load_path += Dir["#{Rails.root}/config/locales/**/*.{rb,yml}"]
  end
end
