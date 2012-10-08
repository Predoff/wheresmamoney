jQuery ($) ->

  ### Funções ###
  minimizeRows = ->
    $('.recent tr, .by-month tr.inline').each ->
      if ($(this).height() > 40)
        $(this).addClass('minimized')
        
    if $('#summary_container li.by-month-tab').hasClass('active')
      $('.by-month table tr.grouped-by-day-row, button.minimize-day-transactions').each ->
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

  ### Botão de troca de mês em visualização by-month ###
  $('#summary_container').delegate 'button.previous-month', 'click', ->
    year = $('.period-selector span.year').data('year')
    currentMonth = $('.period-selector span.month').data('month')
    if  currentMonth isnt 1
      previousMonth = currentMonth - 1
    else
      previousMonth = 12
      year -= 1
    $.ajax
        type: 'GET'
        url: $('ul#navgation_menu li.active a').attr('href')
        data: "selected-month=#{previousMonth}&selected-year=#{year}"

  $('#summary_container').delegate 'button.next-month', 'click', ->
    year = $('.period-selector span.year').data('year')
    currentMonth = $('.period-selector span.month').data('month')
    if  currentMonth isnt 12
      nextMonth = currentMonth + 1
    else
      nextMonth = 1
      year += 1
    $.ajax 
        type: 'GET'
        url: $('ul#navgation_menu li.active a').attr('href')
        data: "selected-month=#{nextMonth}&selected-year=#{year}"

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
    type = 'transaction' if $(this).hasClass('transaction')
    type = 'outgo' if $(this).hasClass('outgo')
    type = 'income' if $(this).hasClass('income')
    $(this).removeClass('minimized-day').addClass('expanded-day')
    $("tr.grouped-by-day-row.#{type}.#{$(this).data("transactions-date")}-transaction-row").fadeIn()
    $(this).find('.transactions-counter-cell:first').fadeOut()
    $(this).find('button.expand-day-transactions:first').hide()
    $(this).find('button.minimize-day-transactions:first').show()

  $('#content_container').delegate 'tr.expanded-day', 'click', ->
    $(this).removeClass('expanded-day').addClass('minimized-day')
    $("tr.grouped-by-day-row.#{$(this).data("transactions-date")}-transaction-row").fadeOut(200)
    $(this).find('.transactions-counter-cell:first').fadeIn()
    $(this).find('button.minimize-day-transactions:first').hide()
    $(this).find('button.expand-day-transactions:first').show()

  ### Hover effect dos botões de expandir e minimizar linhas de dias com mais de uma transação ###
  $('#content_container').delegate 'tr.minimized-day, tr.expanded-day', 'mouseenter mouseleave', ->
    $(this).find('button.expand-day-transactions:first, button.minimize-day-transactions:first').toggleClass('hover')

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