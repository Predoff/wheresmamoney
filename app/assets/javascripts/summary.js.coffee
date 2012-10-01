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
  tr.expanded td.tag-cell,
  tr.minimized td.category-source-cell,
  tr.expanded td.category-source-cell", 
  'click', -> 
    $(this).closest('tr').toggleClass('expanded').toggleClass('minimized')

  ### Filtro de transação por tipo por radio-boxes ###
  $('#content_container').delegate ' form .radio input', 'click', ->
    $('.recent-transaction, .recent-outgo, .recent-income').hide()
    type = $(this).closest('label').data('filter')
    if $("tr.#{type}")
      $('#summary_content .alert.no-transaction-to-show').hide()
      $('#summary_content table').show()
      $("span.#{type}").show()
      $("tr.#{type}").fadeIn()
    else
      $('#summary_content table').hide()
      $('#summary_content .alert.no-transaction-to-show').show()

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