jQuery ($) ->
  $(document).delegate('.login .login_link', 'click', (event) ->
    event.preventDefault()
    $('.login .login_panel').toggle()
  )
