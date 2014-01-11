jQuery ($) ->
  # toggle login panel
  $(document).delegate('.login_link', 'click', (event) ->
    event.preventDefault()
    $('.login_panel').toggle()
    event.stopPropagation()
  )

  # hide panel when you click outside of panel
  $(document).click((event) ->
    loginPanel = $('.login_panel')[0]
    unless $.contains(loginPanel, event.target)
      $('.login_panel').hide()
  )
