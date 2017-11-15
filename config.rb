# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = 'last 2 versions'
end

activate :sprockets

activate :middleman_cache_do do |config|
  config.client = Dalli::Client.new(ENV['MEMCACHEDCLOUD_SERVERS'].split(','), {
    username: ENV['MEMCACHEDCLOUD_USERNAME'],
    password: ENV['MEMCACHEDCLOUD_PASSWORD'],
    namespace: ENV.fetch('CACHE_PREFIX') { 'middleman_cache_do' },
    expires_in: 86_400, # 12 hour default cache.
    compress: true
  }) if ENV['MEMCACHEDCLOUD_SERVERS']
end

OpenExchangeRates.configure do |config|
  config.app_id = ENV['OPEN_EXCHANGE_RATE_API']
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

require 'helpers/trips_helper'
include TripsHelper

# Create all the proxy pages for locations we support
departures.each do |departure|
  destinations.each do |destination|
    proxy "/#{destination.slug}-from-#{departure.alpha2.downcase}.html", '/locations/template.html', locals: { departure: departure, destination: destination }, ignore: true
  end
end

ignore '/locations/template.html'

helpers do
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash, ignore: %r{^images/.*}
   activate :minify_html do |html|
    html.remove_multi_spaces        = true   # Remove multiple spaces
    html.remove_comments            = true   # Remove comments
    html.remove_intertag_spaces     = false  # Remove inter-tag spaces
    html.remove_quotes              = false  # Remove quotes
    html.simple_doctype             = false  # Use simple doctype
    html.remove_script_attributes   = false  # Remove script attributes
    html.remove_style_attributes    = true   # Remove style attributes
    html.remove_link_attributes     = true   # Remove link attributes
    html.remove_form_attributes     = false  # Remove form attributes
    html.remove_input_attributes    = false  # Remove input attributes
    html.remove_javascript_protocol = true   # Remove JS protocol
    html.remove_http_protocol       = false  # Remove HTTP protocol
    html.remove_https_protocol      = false  # Remove HTTPS protocol
    html.preserve_line_breaks       = false  # Preserve line breaks
    html.simple_boolean_attributes  = true   # Use simple boolean attributes
    html.preserve_patterns          = nil    # Patterns to preserve
  end
  activate :gzip
end

activate :cdn do |cdn|
  cdn.cloudfront = {
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    distribution_id: ENV['AWS_CLOUDFRONT_DISTRIBUTION_ID']
  }

  cdn.after_build = ENV['INVALIDATE_CDN_AFTER_BUILD'].present?
end
