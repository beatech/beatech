jQuery ($) ->
  # Tab toggle
  $(document).delegate('.grade_tab_link', 'click', (event) ->
    event.preventDefault()
    gradeTab = $(event.currentTarget).parent()
    unless gradeTab.hasClass('active')
      activateGrade(gradeTab.data('grade'))
  )

  activateGrade = (grade) ->
    gradeTabs = $('.grade_tabs li')
    gradeTabs.each( ->
      if $(this).data('grade') == grade
        $(this).addClass('active')
      else
        $(this).removeClass('active')
    )

    gradeContents = $('.grade_contents .grade_content')
    gradeContents.each( ->
      if $(this).data('grade') == grade
        $(this).addClass('active')
      else
        $(this).removeClass('active')
    )
