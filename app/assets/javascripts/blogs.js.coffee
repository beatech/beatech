jQuery ($) ->
  return if $('body.blogs_controller').length == 0

  $(document).delegate('.write_comment', 'click', (event) ->
    event.preventDefault()
    $(this).hide()
    $(this).closest('.comments').find('.new_comment').removeClass('hidden')
  )
