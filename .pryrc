$: << './lib'
$: << '../lucid_client/lib'
$: << '../lucid_async/lib'

require 'lucid_client'
require 'lucid_cm'

if File.exist?( f = '.pryrc.local' )
  load f
end
