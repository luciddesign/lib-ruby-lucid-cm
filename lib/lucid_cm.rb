require 'lucid_client'

module LucidCM

  extend LucidClient::Env

end

require 'lucid_cm/middleware/base'

middleware = File.dirname( __FILE__ ) + '/lucid_cm/middleware/*.rb'

Dir.glob( middleware ).each do |middleware|
  require middleware
end

require 'lucid_cm/session'
require 'lucid_cm/services/authenticate'

### Exceptions

require 'lucid_cm/exceptions/invalid_token'

### API Interfaces

require 'lucid_cm/api/client_api'
