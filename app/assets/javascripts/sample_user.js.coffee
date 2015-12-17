# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# サンプルユーザーとしてログイン

$ ->
	$('#try_user').click ->
		$('#login-form #user_email').val('sample_user@sample.com')
		$('#login-form #user_password').val('password')
		$("#login-form input[type='submit']").trigger("click")