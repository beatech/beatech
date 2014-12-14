set :stage, :production
set :branch, 'master'
set :rails_env, 'production'
set :migration_role, 'db'

server 'beatech', user: 'beatech', roles: %w{web app db}
