hideRows = ->
  $('tr.recent-transaction').hide()
  $('tr.recent-outgo').hide()
  $('tr.recent-income').hide()

showAlertNoTransactions = ->
  $('#summary_content table').hide()
  $('#summary_content .alert').show()

jQuery ($) ->

  ### Abas ###
  $('#content_container').delegate '.nav a', 'click', ->
    unless $(this).closest('li').hasClass('active')
      $('#content_container .nav li').removeClass('active')
      $(this).closest('li').addClass('active')
      $('#content_container table').addClass('invisible')
      $("table.#{$(this).attr('href')}").removeClass('invisible')  
    false

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
    hideRows()
    if $('tr.recent-outgo')
      $('#summary_content .alert').hide()
      $('#summary_content table').show()
      $('tr.recent-outgo').fadeIn()
    else
      showAlertNoTransactions()
    
  $('input#show_option-incomes').click ->
    hideRows()
    if $('tr.recent-income')
      $('#summary_content .alert').hide()
      $('#summary_content table').show()
      $('tr.recent-income').fadeIn()
    else
      showAlertNoTransactions()

  $('input#show_option-both').click ->
    hideRows()
    if $('tr.recent-income')
      $('#summary_content .alert').hide()
      $('#summary_content table').show()
      $('tr.recent-transaction').fadeIn()
    else
      showAlertNoTransactions()
  
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