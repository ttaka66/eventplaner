# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


initEvents = ->

	# events#new

	# datetimepickerのオプション
	picker_option = {
		# 日本語化 
		locale: "ja"
		# 年月日を時間を横に並べる
		sideBySide: true
		# テキストフィールドの表示形式
		format: "YYYY/MM/DD HH:mm"
		# カレンダーのヘッダーの表示形式
		dayViewHeaderFormat: "YYYY MMMM"
		# 5分ごとに変更できる
		stepping: 5
	}

	# カレンダーから日付を入力する
	$(".datetimepicker").datetimepicker(picker_option)

	# 候補数が変わった時に時刻変更ボックスの数を変更する
	$("#timeplans_cnt").change ->
  	console.log("候補数-1：#{$(this).val() - 1}")
  	$("#timeplans").empty()
  	m = $(this).val()
  	for n in [1..m]
	  	timeplan_now = ($("<div>").attr('id', "timeplan#{n}"))
	  	timeplan_now.append($("<h3>").text("プラン#{n}"))
	  	for i in ['start', 'end']
	  		time_type = if i == 'start' then "開始時間" else "終了時間"
	  		# 要素の作成
		  	form_group = $("<div>").addClass("form_group")
		  	label = $("<label>").attr("for", "event_timeplans_attributes_#{n - 1}_#{i}").text(time_type)
		  	datetimepicker = $("<div>").addClass("input-group date datetimepicker")
		  	input = $("<input>").addClass("form-control").
		  		attr({
		  			id: "event_timeplans_attributes_#{n - 1}_#{i}"
		  			name: "event[timeplans_attributes][#{n - 1}][#{i}]"
		  			placeholder: "YYYY/MM/DD HH:mm"
		  			type: "text"
		  		})
		  	input_group_addon = $("<span>").addClass("input-group-addon")
		  	glyphicon = $("<span>").addClass("glyphicon glyphicon-calendar")
		  	# 要素の組み立て
		  	datetimepicker.append(input).append(input_group_addon.append(glyphicon))
		  	timeplan_now.append(label).append(datetimepicker)
		  $("#timeplans").append(timeplan_now)
	  $(".datetimepicker").datetimepicker(picker_option)

	# 友達リストにマウスが乗った時の処理
	# $('#invite_from_friends_list .user_list').mouseover ->
	# 	$(this).css("cursor","pointer")

	# $('#invite_from_friends_list .invitees').mouseover ->
	# 	$(this).css("cursor","pointer")

	# 友達をクリックした時の処理
	$(document).on "click", '#invite_from_friends_list > .user_list', ->
		user_id = $(this).data('id')
		$(this).after("<input id='invite_#{user_id}' name='invitees[]' type='hidden' value='#{user_id}' />")
		$(this).removeClass("user_list").addClass("invitees")

	$(document).on "click", '#invite_from_friends_list > .invitees', ->
		$(this).removeClass('invitees').addClass('user_list')
		user_id = $(this).data('id')
		$('#invite_' + user_id).remove()

	# events#show

	# 参加不参加ボタンの切り替え
	$(".can").hover ->
		$(this).removeClass("btn-success").addClass("btn-danger").text("私は参加できません")
		return
	, ->
		$(this).removeClass("btn-danger").addClass("btn-success").text("私は参加できます")
		return

	$(".cant").hover ->
		$(this).removeClass("btn-danger").addClass("btn-success").text("私は参加できます")
		return
	, ->
		$(this).removeClass("btn-success").addClass("btn-danger").text("私は参加できません")
		return

# ページロード時にinit関数を実行
$(document).ready(initEvents)
$(document).on('page:change', initEvents)

