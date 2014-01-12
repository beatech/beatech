jQuery ($) ->
  # when you are not logged in
  if $('.login_panel').length
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

  # when you are logged in
  if $('.login_menu_dropdown').length
    # toggle login menu dropdown
    $(document).delegate('.login_menu', 'click', (event) ->
      $('.login_menu_dropdown').toggle()
      $('.login_menu').toggleClass('active')
      event.stopPropagation()
    )

    # hide login menu when you click outside of dropdown
    $(document).click((event) ->
      loginMenu = $('.login_menu_dropdown')[0]
      unless $.contains(loginMenu, event.target)
        $('.login_menu_dropdown').hide()
        $('.login_menu').removeClass('active')
    )
