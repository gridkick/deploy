set :branch    , 'master'
set :deploy_to , "/var/ops/#{ application }/#{ stage }"
set :domain    , 'gridkick.com'
set :user      , 'ubuntu'

server domain , :app , :primary => true
