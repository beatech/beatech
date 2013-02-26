pgrep -f 'unicorn_rails master'
kill -QUIT PID
unicorn_rails -c unicorn.rb -E production -D
