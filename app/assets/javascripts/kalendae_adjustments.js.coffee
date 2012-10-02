jQuery ($) ->

  $('body').delegate '.k-in-month.k-active', 'click', ->
    if $('#outgoes_tab').hasClass('active')
      $('#outgo_category_id').focus()
    else # if $('#incomes_tab').hasClass('active')
      $('#income_source_id').focus()