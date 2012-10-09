jQuery(function($) {
  window.refreshDashboard = function(yearToShow, monthToShow) {
    if ($('#summary_content .period-selector')) {
      if (!monthToShow) {
        monthToShow = $('#summary_content .period-selector span.month').data('month');
      };

      if (!yearToShow) {
        yearToShow = $('#summary_content .period-selector span.year').data('year');
      };

      $.get($('ul#navgation_menu li.active a').attr('href'), {
        "selected-month": monthToShow,
        "selected-year": yearToShow
      });

    } else {
      $.get($('ul#navgation_menu li.active a').attr('href'));
    }
  };
});