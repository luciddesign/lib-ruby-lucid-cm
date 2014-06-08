require 'json'

module LucidCM::Middleware
  class Token < LucidCM::Middleware::Base

    def call( env )
      app.call( env ).on_complete do |env|
        if _access_token_error?( env )
          log_error( msg = 'Campaign Monitor rejected the token' )

          raise LucidCM::Exceptions::InvalidToken, msg
        end
      end
    end

    private

    # There's a little more to it than this, so see Campaign Monitor docs.
    # But for now, this should be fine.
    #
    def _access_token_error?( env )
      if env[:status] == 401
        env[:body] && _token_codes.include?( JSON.parse( env[:body] )['Code'] )
      end
    end

    def _token_codes
      [ 50, 120, 121, 122 ]
    end

  end
end
