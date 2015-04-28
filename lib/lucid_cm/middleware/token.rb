require 'json'

module LucidCM::Middleware
  class Token < Base

    def call( env )
      app.call( env ).on_complete do |env|
        code = _code( env )

        break unless _unauthorized?( env )
        break unless _token_codes.include?( code )

        begin
          raise LucidCM::Exceptions::InvalidToken.new( code )
        rescue => e
          log_error( e.message )

          raise e
        end
      end
    end

    private

    def _code( env )
      b = _body( env )

      b['Code'] if b.kind_of?( Hash )
    end

    def _body( env )
      JSON.parse( env[:body] )
    rescue JSON::ParserError
    end

    def _unauthorized?( env )
      env[:status] == 401
    end

    def _token_codes
      [ 50, 120, 121, 122 ]
    end

  end
end
