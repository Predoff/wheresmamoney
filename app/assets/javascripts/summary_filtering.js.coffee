jQuery ($) ->
	
	$('input#show_option-outgoes').click ->
		$.get $(this).closest("form").data("url"), {type: 'Outgo'} 

	$('input#show_option-incomes').click ->
		$.get $(this).closest("form").data("url"), {type: 'Income'}

	$('input#show_option-both').click ->
		$.get $(this).closest("form").data("url")

	$('input#show_option-both').click()