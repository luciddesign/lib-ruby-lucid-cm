class LucidCM::Session < LucidClient::Session

  attr_reader :token

  def initialize( options = {} )
    @token = options[:token]

    super( options )
  end

  def parse_resource( response )
    parse_response( response )
  end

  private

  def _middleware
    %i{ CallLogger Token }.map do |middleware|
      LucidCM::Middleware.const_get( middleware )
    end
  end

  def _headers
    {
      'Authorization' => "Bearer #{token}",
      'Content-Type'  => 'application/json'
    }
  end

  def _request_path( path )
    "/api/v3.1/#{path}.json"
  end

  def _default_uri
    'https://api.createsend.com/api/v3.1'
  end

end
