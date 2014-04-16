TwitterAccount.blueprint do
  uid { 1 }
  string { 'ikstrm' }
  user { User.make! }
end
