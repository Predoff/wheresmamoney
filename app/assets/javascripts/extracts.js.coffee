jQuery ($) ->

  # Funções
  hideNoTransactionsAlert = ->
    $('#extracts_content table').show()
    $('#extracts_content .alert.no-transaction-to-show').hide()
    if $('#extracts_container li.by-month-tab').hasClass('active')
      $('.total-display').show()

  window.loadContent = (date, date_action) ->
    activeTab = $('#extracts_container ul.nav li.active a')
    if $('.by-month-tab').hasClass('active')
      $.get "/extracts/#{activeTab.attr('href')}",
        date: date
        date_action: date_action
    else
      $.get "/extracts/#{activeTab.attr('href')}"

  minimizeRows = ->
    $('.recent tr, .by-month tr.inline').each ->
      if ($(this).height() > 40)
        $(this).addClass('minimized')

    if $('#extracts_container li.by-month-tab').hasClass('active')
      $('.by-month table tr.grouped-by-day-row, button.minimize-day-transactions').each ->
        $(this).hide()

  showNoTransactionsAlert = ->
    $('#extracts_content table').hide()
    $('#extracts_content .alert.no-transaction-to-show').show()
    $('.total-display').hide() if $('.total-display')


  # Verifica se apágina ativa é a de extratos
  if $('#extracts_container').length > 0
    # Carrega automaticamente ajax da aba ativa
    loadContent()  

    # Botão de troca de mês em visualização by-month
    $('#extracts_container').delegate '.by-month button.previous-month', 'click', ->
      date = $('.period-selector span.month').data('date')
      loadContent(date, "previous")

    $('#extracts_container').delegate '.by-month button.next-month', 'click', ->
      date = $('.period-selector span.month').data('date')
      loadContent(date, "next")

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