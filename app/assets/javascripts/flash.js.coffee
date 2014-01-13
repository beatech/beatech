jQuery ($) ->
  # fade out and remove flash message
  if $(".notice_wrapper").length
    $(".notice_wrapper").delay(1400).fadeOut("slow").queue( ->
      this.remove()
    )
