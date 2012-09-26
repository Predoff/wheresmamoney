jQuery ($) ->
	$('input.tags').select2({
		tags: $("input.tags").data("tags")
	})