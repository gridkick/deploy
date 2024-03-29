##
#
# This is to deploy to a local server running in a VirtualBox
# container. Use the `deploy` repo to build one using Vagrant.
#
# The `ssh_options[ :port ]` should match the forwarded SSH port
# of the VM.
#

if `ssh-add -l | grep ~/.vagrant.d/insecure_private_key`.size == 0
  warn 'The Vagrant VM key should be added to your SSH agent'
  warn 'Run the following command:'
  puts
  warn 'ssh-add ~/.vagrant.d/insecure_private_key'
  exit 42
end

set :branch    , 'all_provider'
set :deploy_to , "/var/ops/#{ application }/#{ stage }"
set :domain    , 'local.gridkick.com'
set :user      , 'vagrant'

server domain , :app , :primary => true
