# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	# events#show

	# 参加不参加ボタンの切り替え
	$(document).on 'mouseover', '.can', ->
		$(this).removeClass("btn-success").addClass("btn-danger").text("私は参加できません")
	$(document).on 'mouseout', '.can', ->
		$(this).removeClass("btn-danger").addClass("btn-success").text("私は参加できます")
	$(document).on 'mouseover', '.cant', ->
		$(this).removeClass("btn-danger").addClass("btn-success").text("私は参加できます")
	$(document).on 'mouseout', '.cant', ->
		$(this).removeClass("btn-success").addClass("btn-danger").text("私は参加できません")