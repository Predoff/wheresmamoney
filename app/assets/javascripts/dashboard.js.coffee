jQuery ($) ->

  ### Inserindo select2 do campo de Tags ###
  $('input.tags').select2({
    tags: $("input.tags").data("tags")
  })

  ### Date Button ###
  $('button.date-button').click ->
    $(this).siblings('input').focus()