jQuery ($) ->

  # Funções
  hideNoTransactionsAlert = ->
    $('#summary_content table').show()
    $('#summary_content .alert.no-transaction-to-show').hide()
    if $('#summary_container li.by-month-tab').hasClass('active')
      $('.total-display').show()

  minimizeRows = ->
    $('.recent tr, .by-month tr.inline').each ->
      if ($(this).height() > 40)
        $(this).addClass('minimized')

    if $('#summary_container li.by-month-tab').hasClass('active')
      $('.by-month table tr.grouped-by-day-row, button.minimize-day-transactions').each ->
        $(this).hide()

  showNoTransactionsAlert = ->
    $('#summary_content table').hide()
    $('#summary_content .alert.no-transaction-to-show').show()
    $('.total-display').hide() if $('.total-display')

  # Abas: Recente | por Mês | por Ano | Personalizado
  $('#content_container').delegate '.nav a', 'click', ->
    unless $(this).closest('li').hasClass('active')
      hideNoTransactionsAlert()      
      $('#content_container .nav li').removeClass('active')
      $(this).closest('li').addClass('active')
      $('.recent, .by-month, .by-year, .custom').addClass('invisible')
      $(".#{$(this).attr('href')}").removeClass('invisible').hide().fadeIn()
      $(".filter_container input:checked").click()
      minimizeRows()
    false

  # Botão de exclusão de transação
  $('#summary_container').delegate '.destroy-transaction', 'click', ->
    if confirm('Tem certeza que deseja excluir esse registro?')
      $.ajax
          type: 'DELETE'
          url: $(this).data('url')

  # Botão de troca de mês em visualização by-month
  $('#summary_container').delegate '.by-month button.previous-month', 'click', ->
    date = $('.period-selector span.month').data('date')
    refreshDashboard(date, "previous")

  $('#summary_container').delegate '.by-month button.next-month', 'click', ->
    date = $('.period-selector span.month').data('date')
    refreshDashboard(date, "next")

  # Expansão e minimização de linhas com conteúdo em overflow
  $('#summary_container').delegate "tr.minimized td.description-cell,
  tr.minimized td.tag-cell,
  tr.expanded td.description-cell,
  tr.expanded td.tag-cell,
  tr.minimized td.category-source-cell,
  tr.expanded td.category-source-cell",
  'click', ->
    $(this).closest('tr').toggleClass('expanded').toggleClass('minimized')

  # Expansão e minimização de linhas de dias com mais de uma transação
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

  # Hover effect dos botões de expandir e minimizar linhas de dias com mais de uma transação
  ###
  $('#content_container').delegate 'tr.minimized-day, tr.expanded-day', 'mouseenter mouseleave', ->
    $(this).find('button.expand-day-transactions:first, button.minimize-day-transactions:first').toggleClass('hover')
  ###
  # Radio-boxes de filtro de transação
  $('#content_container').delegate '#summary_container form .radio input', 'click', ->
    type = $(this).closest('label').data('filter')
    activeTab = $('#summary_container li.active a').attr('href')
    if $(".#{activeTab} tr.#{type}").length > 0
      hideNoTransactionsAlert()
      $('.transaction, .outgo, .income').hide()
      $('#summary_content table').show()
      $("span.#{type}").show()
      $("tr.#{type}").fadeIn()
      minimizeRows()
      $(".total-display .#{type}").hide().fadeIn() if $('.total-display')
    else
      showNoTransactionsAlert()

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
