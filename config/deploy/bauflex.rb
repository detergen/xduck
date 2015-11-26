# differs only with repository url from denstep account

set :repo_url, 'git@github.com:denstep/xduck.git'

role :app, %w{178.79.172.224}
role :web, %w{178.79.172.224}
role :db,  %w{178.79.172.224}

set :full_app_name, "#{fetch(:application)}_bauflex"
set :server_name, '178.79.172.224'

server '178.79.172.224', user: 'deploy', roles: %w{web app db}, primary: true

set :stage, :bauflex
set :branch, "master"
set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:full_app_name)}"

set :rails_env, :production

set :enable_ssl, false
set :nginx_use_ssl, true

set :nginx_server_name, 'x.bauflex.ru'