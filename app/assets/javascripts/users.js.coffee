jQuery ($) ->
	# Change Tab
  $('#login_singnup_container li a').click ->
    unless $(this).closest('li').hasClass('active')
      $('#login_singnup_container li').removeClass('active')
      $(this).closest('li').addClass('active')
      $('#login_form, #signup_form').toggle()
    false

  # Password confirmation slideDown
  $('#signup_form #user_password').keyup ->
  	if $(this).attr('value').length > 0
  		$('#signup_form .confirmation').slideDown(250)
  	else
  		$('#signup_form .confirmation').slideUp(250)