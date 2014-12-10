jQuery ($) ->
  return if $('body.users_controller.index_action').length == 0

  $(document).delegate('.user_grade_tab', 'click', (event) ->
    grade = $(this).data('grade')
    history.pushState(null, null, "/users?grade=#{grade}")
  )
