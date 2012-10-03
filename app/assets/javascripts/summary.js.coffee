jQuery ($) ->

  ### Funções ###

  minimizeByMonthTransactions = ->
    $('.by-month table tr.grouped-by-day-row').each ->
      $(this).hide()

  minimizeRecentTransitions = ->  
    $('.recent tr, .by-month tr.inline').each ->
      if ($(this).height() > 40)
        $(this).addClass('minimized')

  ### Abas: Recente | por Mês | por Ano | Personalizado ###
  $('#content_container').delegate '.nav a', 'click', ->
    unless $(this).closest('li').hasClass('active')
      $('#content_container .nav li').removeClass('active')
      $(this).closest('li').addClass('active')
      $('.recent, .by-month, .by-year, .custom').addClass('invisible')
      $(".#{$(this).attr('href')}").removeClass('invisible')
      $('#content_container h2').addClass('invisible')
      $("h2.#{$(this).attr('href')}").removeClass('invisible')
    false

  ### Botão de exclusão de transação ###
  $('#summary_container').delegate '.destroy-transaction', 'click', ->
    if confirm('Tem certeza que deseja excluir esse registro?')
      $.ajax 
          type: 'DELETE'
          url: $(this).data('url')

  ### Expansão e minimização de linhas por click da tabela de exibição de Recentes ###
  $('#summary_container').delegate "tr.minimized td.description-cell, 
  tr.minimized td.tag-cell, 
  tr.expanded td.description-cell, 
  tr.expanded td.tag-cell,
  tr.minimized td.category-source-cell,
  tr.expanded td.category-source-cell", 
  'click', -> 
    $(this).closest('tr').toggleClass('expanded').toggleClass('minimized')

  ### Radio-boxes de filtro de transação ###
  $('#content_container').delegate 'form .radio input', 'click', ->
    $('.transaction, .outgo, .income').hide()
    type = $(this).closest('label').data('filter')
    if $("tr.#{type}")
      $('#summary_content .alert.no-transaction-to-show').hide()
      $('#summary_content table').show()
      $("span.#{type}").show()
      $("tr.#{type}").fadeIn()
    else
      $('#summary_content table').hide()
      $('#summary_content .alert.no-transaction-to-show').show()
    minimizeRecentTransitions()
    minimizeByMonthTransactions()

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