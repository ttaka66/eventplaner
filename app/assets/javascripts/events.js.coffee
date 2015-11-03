# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$ ->
	console.log('セット')
	# $('#chat').ready ->
 #  	alert 'hello chat'


initEvents = ->
	console.log('initEventsセット')

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

	handler = Gmaps.build('Google')
	handler.buildMap { provider: {}, internal: {id: 'map'}}, ->
		map_info = $('#map_info').data('json')
		markers = handler.addMarkers(map_info)
		handler.bounds.extendWith(markers)
		handler.fitMapToBounds()
		handler.getMap().setZoom(15)
		return

  success = (response) ->
  	console.log("event_confirmationイベントが発生しました: " + response.message)
  	return


	failure = (response) ->
  	console.log("event_confirmationイベント生成に失敗しました " + response.message)
  	return

  # $('#chat').ready ->
  # 	alert 'hello chat'

  return



# ページロード時にinit関数を実行
$(document).ready(initEvents)
$(document).on('page:change', initEvents)

