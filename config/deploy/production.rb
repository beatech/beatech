set :stage, :production
set :branch, 'master'
set :rails_env, 'production'
set :migration_role, 'db'

server 'beatech.net', user: 'beatech', port: '8931', roles: %w{web app db}
