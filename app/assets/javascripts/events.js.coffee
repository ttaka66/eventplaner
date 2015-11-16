# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$ ->
	console.log('セット')

initEvents = ->

	# event#new

	# 候補数が変わった時に時刻変更ボックスの数を変更する
	$('#timeplans_cnt').change ->
  	console.log("候補数：#{$(this).val()}")


	$(".can").hover ->
		$(this).removeClass("btn-success").addClass("btn-danger").text("参加できません")
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

  success = (response) ->
  	console.log("event_confirmationイベントが発生しました: " + response.message)
  	return


	failure = (response) ->
  	console.log("event_confirmationイベント生成に失敗しました " + response.message)
  	return

# ページロード時にinit関数を実行
$(document).ready(initEvents)
$(document).on('page:change', initEvents)

