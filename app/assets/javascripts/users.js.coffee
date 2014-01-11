jQuery ($) ->
  # Disable active tab link
  $(document).delegate('#users .grade_tab .active a', 'click', (event) ->
    event.preventDefault()
  )
