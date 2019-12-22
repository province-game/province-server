require 'hanami/helpers'
require 'hanami/assets'

module Api
  class Application < Hanami::Application
    configure do
      ##
      # BASIC
      #

      # Define the root path of this application.
      # All paths specified in this configuration are relative to path below.
      #
      root __dir__

      # Relative load paths where this application will recursively load the
      # code.
      #
      # When you add new directories, remember to add them here.
      #
      load_paths << %w[controllers]

      # Handle exceptions with HTTP statuses (true) or don't catch them (false).
      # Defaults to true.
      # See: http://www.rubydoc.info/gems/hanami-controller/#Exceptions_management
      #
      # handle_exceptions true

      ##
      # HTTP
      #

      # Routes definitions for this application
      # See: http://www.rubydoc.info/gems/hanami-router#Usage
      #
      routes 'config/routes'

      # URI scheme used by the routing system to generate absolute URLs
      # Defaults to "http"
      #
      # scheme 'https'

      # URI host used by the routing system to generate absolute URLs
      # Defaults to "localhost"
      #
      # host 'example.org'

      # URI port used by the routing system to generate absolute URLs
      # Argument: An object coercible to integer, defaults to 80 if the scheme
      # is http and 443 if it's https
      #
      # This should only be configured if app listens to non-standard ports
      #
      # port 443

      # Enable cookies
      # Argument: boolean to toggle the feature
      #           A Hash with options
      #
      # Options:
      #   :domain   - The domain (String - nil by default, not required)
      #   :path     - Restrict cookies to a relative URI
      #               (String - nil by default)
      #   :max_age  - Cookies expiration expressed in seconds
      #               (Integer - nil by default)
      #   :secure   - Restrict cookies to secure connections
      #               (Boolean - Automatically true when using HTTPS)
      #               See #scheme and #ssl?
      #   :httponly - Prevent JavaScript access (Boolean - true by default)
      #
      # cookies true
      # or
      # cookies max_age: 300

      # Enable sessions
      # Argument: Symbol the Rack session adapter
      #           A Hash with options
      #
      # See: http://www.rubydoc.info/gems/rack/Rack/Session/Cookie
      #
      sessions :cookie, secret: ENV['WEB_SESSIONS_SECRET']

      default_request_format :json

      default_response_format :json

      security.x_frame_options 'DENY'

      security.x_content_type_options 'nosniff'

      security.x_xss_protection '1; mode=block'

      security.content_security_policy %{
        form-action 'self';
        frame-ancestors 'self';
        base-uri 'self';
        default-src 'none';
        script-src 'self';
        connect-src 'self';
        img-src 'self' https: data:;
        style-src 'self' 'unsafe-inline' https:;
        font-src 'self';
        object-src 'none';
        plugin-types application/pdf;
        child-src 'self';
        frame-src 'self';
        media-src 'self'
      }

      ##
      # FRAMEWORKS
      #

      # Configure the code that will yield each time Web::Action is included
      # This is useful for sharing common functionality
      #
      # See: http://www.rubydoc.info/gems/hanami-controller#Configuration
      controller.prepare do
        include Api::Authentication
        # before :authenticate!    # run an authentication before callback
      end

      # Configure the code that will yield each time Web::View is included
      # This is useful for sharing common functionality
      #
      # See: http://www.rubydoc.info/gems/hanami-view#Configuration
      view.prepare do
        include Hanami::Helpers
        include Api::Assets::Helpers
      end

      middleware.use Warden::Manager do |manager|
        manager.failure_app = Api::Controllers::Sessions::Failure.new
      end

      middleware.use OmniAuth::Builder do
        provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], provider_ignores_state: true
      end
    end

    ##
    # DEVELOPMENT
    #
    configure :development do
      # Don't handle exceptions, render the stack trace
      handle_exceptions false
    end

    ##
    # TEST
    #
    configure :test do
      # Don't handle exceptions, render the stack trace
      handle_exceptions false
    end

    ##
    # PRODUCTION
    #
    configure :production do
      # scheme 'https'
      # host   'example.org'
      # port   443
    end
  end
end
