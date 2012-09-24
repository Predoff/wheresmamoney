jQuery ($) ->
	$('select.tags').select2({
		tags: $("select.tags").data("tags")
	})