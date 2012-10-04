jQuery ($) ->

  ### Funções ###
  minimizeRows = ->
    $('.recent tr, .by-month tr.inline').each ->
      if ($(this).height() > 40)
        $(this).addClass('minimized')
        
    if $('#summary_container li.by-month-tab').hasClass('active')
      $('.by-month table tr.grouped-by-day-row').each ->
        $(this).hide()

  ### Abas: Recente | por Mês | por Ano | Personalizado ###
  $('#content_container').delegate '.nav a', 'click', ->
    unless $(this).closest('li').hasClass('active')
      $('#content_container .nav li').removeClass('active')
      $(this).closest('li').addClass('active')
      $('.recent, .by-month, .by-year, .custom').addClass('invisible')
      $(".#{$(this).attr('href')}").removeClass('invisible').hide().fadeIn()
    minimizeRows()
    false

  ### Botão de exclusão de transação ###
  $('#summary_container').delegate '.destroy-transaction', 'click', ->
    if confirm('Tem certeza que deseja excluir esse registro?')
      $.ajax 
          type: 'DELETE'
          url: $(this).data('url')

  ### Expansão e minimização de linhas com conteúdo em overflow ###
  $('#summary_container').delegate "tr.minimized td.description-cell, 
  tr.minimized td.tag-cell, 
  tr.expanded td.description-cell, 
  tr.expanded td.tag-cell,
  tr.minimized td.category-source-cell,
  tr.expanded td.category-source-cell", 
  'click', -> 
    $(this).closest('tr').toggleClass('expanded').toggleClass('minimized')

  ### Expansão e minimização de linhas de dias com mais de uma transação ###
  $('#content_container').delegate 'tr.minimized-day', 'click', ->
    $(this).removeClass('minimized-day').addClass('expanded-day')
    $("tr.grouped-by-day-row.#{$(this).data("transactions-date")}-transaction-row").fadeIn()

  $('#content_container').delegate 'tr.expanded-day', 'click', ->
    $(this).removeClass('expanded-day').addClass('minimized-day')
    $("tr.grouped-by-day-row.#{$(this).data("transactions-date")}-transaction-row").fadeOut()

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
    minimizeRows()

    if $('.total-display')
      $(".total-display .#{type}").hide().fadeIn()

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