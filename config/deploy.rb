# config valid only for Capistrano 3.1
lock '3.4.0'

set :application, 'xduck'
set :repo_url, 'git@github.com:detergen/xduck.git'

set :deploy_user, 'deploy'

set :pty, true

set :linked_files, %w{config/database.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 5

set :rbenv_type, :system
set :rbenv_ruby, '2.1.2'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set(:symlinks, [
                 {
                     source: "nginx.conf",
                     link: "/etc/nginx/sites-enabled/#{fetch(:full_app_name)}"
                 },
                 {
                     source: "unicorn_init.sh",
                     link: "/etc/init.d/unicorn_#{fetch(:full_app_name)}"
                 },
                 {
                     source: "log_rotation",
                     link: "/etc/logrotate.d/#{fetch(:full_app_name)}"
                 }#,
             #{
             #    source: "monit",
             #    link: "/etc/monit/conf.d/#{fetch(:full_app_name)}.conf"
             #}
             ])

set(:config_files, %w(
  nginx.conf
  database.example.yml
  log_rotation
  unicorn.rb
  unicorn_init.sh
))

set(:executable_config_files, %w(
  unicorn_init.sh
))


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
