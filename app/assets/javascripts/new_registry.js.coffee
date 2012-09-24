jQuery ($) ->
	
	$('li#outgoes_tab a').click ->
		unless $(this).parent().hasClass('active')
			$('#new_register_container li').removeClass('active')
			$(this).parent().addClass('active')

			$.get $(this).data("url")

		false

	$('li#incomes_tab a').click ->
		unless $(this).parent().hasClass('active')
			$('#new_register_container li').removeClass('active')
			$(this).parent().addClass('active')
		
			$.get $(this).data("url")
		
		false

	$.get $('li#outgoes_tab a').data("url")

