# BEATECH [![Build Status](https://travis-ci.org/k0kubun/beatech.png?branch=master)](https://travis-ci.org/k0kubun/beatech)
SNS for BEATECH  
http://beatech.net

## Setup
First, you should run following commands.
```
$ git clone https://github.com/k0kubun/beatech
$ cd beatech
$ bundle install
$ bundle exec rake setup
```

By `rake setup`, dummy twitter credentials are configured and DB is set up.

## Development
You can run beatech as follows
```
$ bundle exec rails server
```
Open `http://localhost:3000/`, then you can see beatech website.

## Run test
```
$ bundle exec rspec .
```

## Contributing

1. Fork it  
2. Create your feature branch (`git checkout -b my-new-feature`)  
3. Commit your changes (`git commit -am 'Add some feature'`)  
4. Push to the branch (`git push origin my-new-feature`)  
5. Create new Pull Request
