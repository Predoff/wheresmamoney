window.loadContent = (date, date_action) ->
	jQuery ($) ->
		activeNavLink = $('#header li.active a').attr('href')

		if activeNavLink is '/extratos'
	    activeTabLink = $('#extracts_container ul.nav li.active a').attr('href')

	    if $('#extracts_container li.by-month-tab').hasClass('active')

        if $('.period-selector span.month').length > 0
          date = $('.period-selector span.month').data('date') if not date?

        console.log date
        $.get "/extracts/#{activeTabLink}",
          date: date
          date_action: date_action

	    else
	      $.get "/extracts/#{activeTabLink}"

	  else
	  	$get activeNavLink