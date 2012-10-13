window.loadContent = (date, date_action) ->
	jQuery ($) ->
		activeNavLink = $('#header li.active a').attr('href')

		if activeNavLink is '/extratos'
	    activeTabLink = $('#extracts_container ul.nav li.active a').attr('href')

	    if $('li.by-month-tab').hasClass('active') or $('li.by-year-tab').hasClass('active')

        if not date? then date = $('.period-selector span.date').data('date')

        $.get "/extracts/#{activeTabLink}",
          date: date
          date_action: date_action

	    else
	      $.get "/extracts/#{activeTabLink}"

	  else
	  	$get activeNavLink