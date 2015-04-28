require 'json'

module LucidCM::Middleware
  class Token < Base

    TOKEN_CODES = [ 50, *120..122 ]

    def call( env )
      app.call( env ).on_complete &method( :_response_handler )
    end

    private

    def _data( res )
      JSON.parse( res[:body] )
    rescue JSON::ParserError
    end

    def _code( data )
      data['Code'] if data.kind_of?( Hash )
    end

    def _response_handler( res )
      data = _data res
      code = _code data

      if res[:status] == 401 && TOKEN_CODES.include?( code )
        _raise_for( code )
      end
    end

    def _raise_for( code )
      raise LucidCM::Exceptions::InvalidToken.new( code ).tap do |e|
        log_error( e.message )
      end
    end

  end
end
