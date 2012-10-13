jQuery ($) ->

  # Funções
  hideNoTransactionsAlert = ->
    $('#extracts_content table').hide().fadeIn()
    $('#extracts_content .alert.no-transaction-to-show').hide()
    if $('#extracts_container li.by-month-tab').hasClass('active')
      $('.total-display').show()

  minimizeRows = ->
    $('.recent tr, .by-month tr.inline').each ->
      if ($(this).height() > 40)
        $(this).addClass('minimized')

    if $('#extracts_container li.by-month-tab').hasClass('active')
      $('.by-month table tr.grouped-by-day-row, button.minimize-day-transactions').each ->
        $(this).hide()

  showNoTransactionsAlert = ->
    $('#extracts_content table').hide()
    $('#extracts_content .alert.no-transaction-to-show').hide().fadeIn()
    $('.total-display').hide() if $('.total-display')

  # Carrega automaticamente ajax da aba ativa
  loadContent()  

  # Abas: Recente | por Mês | por Ano | Personalizado
  $('#content_container').delegate '.nav a', 'click', ->
    unless $(this).closest('li').hasClass('active')
      hideNoTransactionsAlert() 
      $('#content_container .nav li').removeClass('active')
      $(this).closest('li').addClass('active')
      loadContent()
    false

  # Botão de exclusão de transação
  $('#extracts_container').delegate '.destroy-transaction', 'click', ->
    if confirm('Tem certeza que deseja excluir esse registro?')
      $.ajax
          type: 'DELETE'
          url: $(this).data('url')

  # Botões de troca de período em visualização by-month e by-year
  $('#content_container').delegate '.period-selector button.previous', 'click', ->
    date = $('.period-selector span.date').data('date')
    loadContent(date, "previous")

  $('#content_container').delegate '.period-selector button.next', 'click', ->
    date = $('.period-selector span.date').data('date')
    loadContent(date, "next")

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
  $('#content_container').delegate 'tr.minimized-day, tr.expanded-day', 'mouseenter mouseleave', ->
    $(this).find('button.expand-day-transactions:first, button.minimize-day-transactions:first').toggleClass('hover')

  # Radio-boxes de filtro de transação ###
  $('#content_container').delegate 'form .radio input', 'click', ->
    type = $(this).closest('label').data('filter')
    if $("tr.#{type}").length > 0
      hideNoTransactionsAlert()
      $('.transaction, .outgo, .income').hide()
      $('#extracts_content table').show()
      $("span.#{type}").show()
      $("tr.#{type}").fadeIn()
      minimizeRows()
      $(".total-display .#{type}").hide().fadeIn() if $('.total-display')
    else
      showNoTransactionsAlert()