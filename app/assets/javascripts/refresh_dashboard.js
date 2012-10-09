var currentShowingMonth, currentShowingYear;

window.refreshDashboard = function() {
  if ($('#summary_content .period-selector')) {
    currentShowingMonth = $('#summary_content .period-selector span.month').data('month');
    currentShowingYear = $('#summary_content .period-selector span.year').data('year');
  $.get($('ul#navgation_menu li.active a').attr('href'), {
    "selected-month": currentShowingMonth,
    "selected-year": currentShowingYear
  });
  } else {
    $.get($('ul#navgation_menu li.active a').attr('href'));
  }
};