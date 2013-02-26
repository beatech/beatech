kill `pgrep -f 'unicorn_rails master'`
unicorn_rails -c unicorn.rb -E production -D
