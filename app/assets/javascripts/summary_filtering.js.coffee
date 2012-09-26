jQuery ($) ->
	
	$('input#show_option-outgoes').click ->
		$.get $(this).parent().data("url")

	$('input#show_option-incomes').click ->
		$.get $(this).parent().data("url")

	$('input#show_option-both').click ->
		$.get $(this).parent().data("url")
			
	$.get $('input#show_option-both').parent().data("url")
