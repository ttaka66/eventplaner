# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

change_botton = ->
	# $('.can').click ->
	# 	alert "hello"
	# 	return
	# return
	$(".can").hover ->
		$(this).removeClass("btn-success").addClass("btn-danger").text("参加できません").value("参加できません")
		return
	, ->
		$(this).removeClass("btn-danger").addClass("btn-success").text("参加できます")
		return

	$(".cant").hover ->
		$(this).removeClass("btn-danger").addClass("btn-success").text("参加できます")
		return
	, ->
		$(this).removeClass("btn-success").addClass("btn-danger").text("参加できません")
		return

	return

# ページロード時にinit関数を実行
$(document).ready(change_botton)
$(document).on('page:change', change_botton)