set :application, 'beatech'
set :repo_url, 'git://github.com/beatech/beatech.git'
set :deploy_to, '~/beatech'
set :log_level, :info

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets}
set :linked_files, %w{.env config/database.yml config/initializers/omniauth.rb}

set :ssh_options, {
  keys: [File.expand_path('~/aws-beatech.pem')],
  forward_agent: true,
  auth_methods: %w(publickey)
}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end
after 'deploy:publishing', 'deploy:restart'
