jQuery ($) ->
	
	$('li#outgoes_tab a').click ->
		unless $(this).parent().hasClass('active')
			$('#new_transaction_container li').removeClass('active')
			$(this).parent().addClass('active')
			$('form#incomes_form, form#outgoes_form').toggleClass('invisible')

		false

	$('li#incomes_tab a').click ->
		unless $(this).parent().hasClass('active')
			$('#new_transaction_container li').removeClass('active')
			$(this).parent().addClass('active')
			$('form#incomes_form, form#outgoes_form').toggleClass('invisible')

		false

