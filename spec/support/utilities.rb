def login_as(user)
  session[:username] = user.username
end
