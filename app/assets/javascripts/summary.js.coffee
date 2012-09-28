jQuery ($) ->
	
  ### Botão de exclusão de transação ###

  $('#summary_container').delegate '.destroy-transaction', 'click', ->
    if confirm('Tem certeza que deseja excluir esse registro?')
      $.ajax 
          type: 'DELETE'
          url: $(this).data('url')

  ### Expansão e minimização de linhas da tabela de exibição por click ###

  $('#summary_container').delegate "tr.minimized td.description-cell, 
  tr.minimized td.tag-cell, 
  tr.expanded td.description-cell, 
  tr.expanded td.tag-cell", 
  'click', -> 
    $(this).closest('tr').toggleClass('expanded').toggleClass('minimized')

  ### Filtro de transação por tipo por radio-boxes ###

  $('input#show_option-outgoes').click ->
    $.get $(this).closest("form").data("url"), {type: 'Outgo'}
    
  $('input#show_option-incomes').click ->
    $.get $(this).closest("form").data("url"), {type: 'Income'}

  $('input#show_option-both').click ->
    $.get $(this).closest("form").data("url")

  $('input#show_option-both').click()

  ### Tentativa fail de fazer expansão de linhas com hover ###
  ###
    hoverTimeout = {}
    $('#summary_container').delegate 'tr.minimized', 'mouseenter', ->
      hoverTimeout[$(this).data('transaction-id')] = setTimeout =>
        $(this).addClass('expanded').removeClass('minimized')
      , 2000

    $('#summary_container').delegate 'tr.expanded', 'mouseleave', ->
      console.log hoverTimeout[$(this).data('transaction-id')]
      clearTimeout hoverTimeout[$(this).data('transaction-id')]
      $(this).addClass('minimized').removeClass('expanded')
  ###