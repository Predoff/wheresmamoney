cleanTags = (formId) ->
	$("##{formId} .tags").select2("val", "")

jQuery ($) ->
	
	### Change Tab ###
	$('#new_transaction_container li a').click ->
		unless $(this).closest('li').hasClass('active')
			$('#new_transaction_container li').removeClass('active')
			$(this).closest('li').addClass('active')
			$('form#incomes_form, form#outgoes_form').toggleClass('invisible')
		false

	### Clean Form ###
	$("#outgoes_form input[type=reset]").click ->
		cleanTags('outgoes_form')

	$("#incomes_form input[type=reset]").click ->
		cleanTags('incomes_form')