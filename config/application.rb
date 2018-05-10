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

    if ENV['MEMCACHEDCLOUD_SERVERS']
      config.cache_store = :dalli_store,
                           (ENV['MEMCACHEDCLOUD_SERVERS'] || '').split(','),
                           { username: ENV['MEMCACHEDCLOUD_USERNAME'],
                             password: ENV['MEMCACHEDCLOUD_PASSWORD'],
                             failover: true,
                             socket_timeout: 1.5,
                             socket_failure_delay: 0.2,
                             down_retry_delay: 60 }
    end

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

    # Let us break our I18n into lots of smaller files.
    config.i18n.load_path += Dir["#{Rails.root}/config/locales/**/*.{rb,yml}"]
  end
end
