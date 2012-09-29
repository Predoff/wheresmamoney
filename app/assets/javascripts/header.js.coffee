jQuery ($) ->
	$('ul#navgation_menu a').click ->
		unless $(this).closest('li').hasClass('active')
			$.get $(this).attr('href')
		false

	$.get $('ul#navgation_menu li.active a').attr('href')