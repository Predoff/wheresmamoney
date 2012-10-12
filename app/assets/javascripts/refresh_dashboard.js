jQuery(function($) {
  window.refreshDashboard = function(date, date_action) {
    if ($('#summary_content .period-selector')) {
      $.get($('ul#navgation_menu li.active a').attr('href'), {
        "date": date,
        "date_action": date_action,
      });

    } else {
      $.get($('ul#navgation_menu li.active a').attr('href'));
    }
  };
});
