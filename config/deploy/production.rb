set :stage, :production
set :branch, "popkirby-conoha"
set :rails_env, 'production'
set :migration_role, 'db'

server 'beatech', user: 'beatech', roles: %w{web app db}
