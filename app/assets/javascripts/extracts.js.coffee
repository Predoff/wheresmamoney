jQuery ($) ->

  ### Funções ###
  hideNoTransactionsAlert = ->
    $('#extracts_content table').show()
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
    $('#extracts_content .alert.no-transaction-to-show').show()
    $('.total-display').hide() if $('.total-display')


  # Verifica se apágina ativa é a de extratos
  if $('#extracts_container').length > 0

    # Carregar automaticamente ajax da aba ativa
    activeTab = $('#extracts_container ul.nav li.active a')
    $.get "/extracts/#{activeTab.attr('href')}"

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