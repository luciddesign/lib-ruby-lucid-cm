require 'faraday'
require 'rack'
require 'json'
require 'pathname'

module LucidCM
  class Authenticate

    attr_accessor :options

    def initialize( options = {} )
      @options = _default_options.merge( options )
    end

    # eg. at, rt, ex = auth.request_token( params['code'] )
    #
    def request_token( code )
      response = Faraday.post _token_uri.to_s, _token_params( code )
      json     = JSON.parse( response.body )

      %w{ access_token refresh_token expires_in }.map do |attr|
        json[attr]
      end
    end

    # Redirect user here for authorization.
    #
    def code_uri
      "#{_auth_uri}?#{_auth_params_string}"
    end

    private

    def _default_options
      {
        :client_id     => LucidCM.client_env( :client_id ),
        :client_secret => LucidCM.client_env( :client_secret ),
        :callback_uri  => LucidCM.client_env( :callback_uri ),
        :scope         => 'ManageLists'
      }
    end

    def _auth_params_string
      Rack::Utils.build_query( _auth_params )
    end

    def _auth_params
      {
        :type          => 'web_server',
        :client_id     => options[:client_id],
        :redirect_uri  => options[:callback_uri],
        :scope         => options[:scope]
      }
    end

    def _token_params( code )
      {
        :grant_type    => 'authorization_code',
        :client_id     => options[:client_id],
        :client_secret => options[:client_secret],
        :redirect_uri  => options[:callback_uri],
        :code          => code
      }
    end

    def _auth_uri
      Pathname.new( 'https://api.createsend.com/oauth' )
    end

    def _token_uri
      _auth_uri.join( 'token' )
    end

  end
end
