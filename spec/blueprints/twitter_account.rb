TwitterAccount.blueprint do
  uid { 1 }
  screen_name { 'ikstrm' }
  user { User.make! }
end
