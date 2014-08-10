set :stage, :production
set :branch, 'master'
set :rails_env, 'production'
set :migration_role, 'db'

server 'sakura', user: 'ikstrm', roles: %w{web app db}
