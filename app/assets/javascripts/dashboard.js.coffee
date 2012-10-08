jQuery ($) ->

  ### Inserindo select2 do campo de Tags ###
  $('input.tags').select2({
    tags: $("input.tags").data("tags")
  })