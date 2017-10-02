# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :sprockets

activate :middleman_cache_do do |config|
  config.client = Dalli::Client.new(ENV['MEMCACHEDCLOUD_SERVERS'].split(','), {
    username: ENV['MEMCACHEDCLOUD_USERNAME'],
    password: ENV['MEMCACHEDCLOUD_PASSWORD'],
    namespace: 'middleman_cache_do',
    compress: true
  }) if ENV['MEMCACHEDCLOUD_SERVERS']
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Create all the proxy pages for locations we support
supported_countries = @app.data.locations
supported_countries.each do |from_key, from_location|
  supported_countries.each do |to_key, to_location|
    if from_location[:slug] != to_location[:slug]
      proxy "/#{from_location[:slug]}-from-#{to_location[:slug]}.html", '/locations/template.html', locals: { from_location: from_key, to_location: to_key }, ignore: true
    end
  end
end

ignore '/locations/template.html'

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

helpers do
  def location_combinations
    final_location_combinations = []

    data.locations.each do |from_key, _from_location|
      data.locations.each do |to_key, _to_location|
        if from_key != to_key
          final_location_combinations << [location_data_for(from_key), location_data_for(to_key)]
        end
      end
    end

    final_location_combinations
  end

  def location_data_for(location)
    country_data = ISO3166::Country.new(data.locations[location].country)
    data.locations[location].merge({
      title: data.locations[location].title,
      latitude_dec: country_data.latitude_dec,
      longitude_dec: country_data.longitude_dec,
      currency: country_data.currency,
      languages: country_data.languages
    })
  end

  # from: https://apidock.com/rails/ActiveSupport/Inflector/parameterize
  def parameterize(string, sep = '-')
    # replace accented chars with their ascii equivalents
    parameterized_string = transliterate(string)
    # Turn unwanted chars into the separator
    parameterized_string.gsub!(/[^a-z0-9\-_]+/, sep)
    unless sep.nil? || sep.empty?
      re_sep = Regexp.escape(sep)
      # No more than one of the separator in a row.
      parameterized_string.gsub!(/#{re_sep}{2,}/, sep)
      # Remove leading/trailing separator.
      parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/, '')
    end
    parameterized_string.downcase
  end
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
