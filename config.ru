require 'rubygems'
require 'bundler'
Bundler.setup

require 'dotenv'
Dotenv.load

require 'middleman-core/load_paths'
::Middleman.setup_load_paths

require 'middleman-core'
require 'middleman-core/rack'

require 'fileutils'
FileUtils.mkdir('log') unless File.exist?('log')
::Middleman::Logger.singleton("log/#{ENV['RACK_ENV']}.log")

# Keep out the unwanted people.
if ENV['REQUIRE-AUTH'] && ENV['REQUIRE-AUTH'] == 'true'
  use Rack::Auth::Basic, 'Restricted Area' do |username, password|
    [username, password] == %w[awesome awesome]
  end
end

# When in production, use the build folder.
if ENV['SERVE_STATIC'] && ENV['SERVE_STATIC'] == 'true'
  # Serve static files under a `build` directory:
  # - `/` will try to serve your `build/index.html` file
  # - `/foo` will try to serve `build/foo` or `build/foo.html` in that order
  # - missing files will try to serve build/404.html or a tiny default 404 page

  module Rack
    class TryStatic
      def initialize(app, options)
        @app = app
        @try = ['', *options.delete(:try)]
        @static = ::Rack::Static.new(-> { [404, {}, []] }, options)
      end

      def call(env)
        orig_path = env['PATH_INFO']
        found = nil

        @try.each do |path|
          resp = @static.call(env.merge!('PATH_INFO' => orig_path + path))
          break if resp[0] != 404 && found = resp
        end

        found || @app.call(env.merge!('PATH_INFO' => orig_path))
      end
    end
  end

  use Rack::TryStatic,
    root: 'build',
    urls: %w[/], try: ['.html', 'index.html', '/index.html'],
    header_rules: [
      [:all, {
        #'X-Frame-Options' => 'SAMEORIGIN',
        'X-XSS-Protection' => '1; mode=block',
        'X-Content-Type-Options' => 'nosniff',
        'Content-Security-Policy' => ENV.fetch('CONTENT_SECURITY_POLICY') { '' },
        'Strict-Transport-Security' => 'max-age=15552000; includeSubDomains',
        'Referrer-Policy' => 'no-referrer-when-downgrade',
        'Access-Control-Allow-Origin' => '*',
        'Cache-Control' => 'public, max-age=86400'
      }],
      [['png', 'jpg', 'js', 'css', 'svg', 'woff', 'ttf', 'eot'], { 'Cache-Control' => 'public, max-age=31536000' }]
    ]

  # Run your own Rack app here or use this one to serve 404 messages:
  run lambda { |_env|
    not_found_page = File.expand_path('../build/404/index.html', __FILE__)
    if File.exist?(not_found_page)
      [404, { 'Content-Type'  => 'text/html' }, [File.read(not_found_page)]]
    else
      [404, { 'Content-Type'  => 'text/html' }, ['404 - page not found']]
    end
  }

else
  # Otherwise run middleman server as a rack app.
  app = ::Middleman::Application.new
  run ::Middleman::Rack.new(app).to_app
end
