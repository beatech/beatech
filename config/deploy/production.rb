set :stage, :production
set :branch, 'master'
set :rails_env, 'production'
set :migration_role, 'db'

server '52.68.234.246', user: 'beatech', port: '22', roles: %w{web app db}
