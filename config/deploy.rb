require 'capistrano/ext/multistage'

set :application                , 'adventure-deploy'
set :default_run_options        , :pty => true
set :default_stage              , 'staging'
set :deploy_via                 , :remote_cache
set :normalize_asset_timestamps , false
set :repository                 , 'git@github.com:venture-io/deploy.git'
set :scm                        , :git
set :stages                     , [ 'production' , 'staging' , 'local' ]
set :use_sudo                   , false

ssh_options[ :forward_agent ] = true

namespace :deploy do
  task :create_deploy_to_location do
    "mkdir -p #{ deploy_to }"
  end

  task :start   do; end
  task :stop    do; end
  task :restart do; end

  task :update_deploy_to_permissions do
    "chown -hR #{ user }:root #{ deploy_to }"
  end
end

before \
  'deploy:setup',
  'deploy:create_deploy_to_location'

after \
  'deploy:setup',
  'deploy:update_deploy_to_permissions'
