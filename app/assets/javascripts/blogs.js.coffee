jQuery ($) ->
  return if $("body.blogs").length == 0

  $(document).delegate(".write_comment", "click", ->
    $(this).hide()
    $(this).closest(".comments").find(".new_comment").removeClass("hidden")
  )

