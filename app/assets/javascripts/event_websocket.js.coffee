class @ChatClass
  constructor: (url, useWebsocket) ->
    # これがソケットのディスパッチャー
    console.log("url(websocket): #{url}")

    @dispatcher = new WebSocketRails(url, useWebsocket)
    @event_id = $('#chat').data('event')
    @send_user_name = $('#chat').data('username')
    @channel = @dispatcher.subscribe("#{@event_id}")

    console.log(@channel)

    @dispatcher.on_open = (data) ->
    	console.log('Websocketの接続成功: ', data)

    # イベントを監視
    @bindEvents()
 
  bindEvents: () =>
    # commentの保存が成功したらwebsocketサーバーに送信(@sendCommentメソッド)
    $('#chat').on 'ajax:success', @sendComment
    # entryの保存が成功したら@sendEntryメソッドを実行
    $(document).on 'ajax:success', '.entry_form', @sendEntry
    # サーバーからnew_commentイベントを受け取ったらreceiveCommentメソッドを実行
    @channel.bind 'new_comment', @receiveComment
    # サーバーからnew_entryイベントを受け取ったらreceiveEntryメソッドを実行
    @channel.bind 'new_entry', @receiveEntry
 
  sendComment: (e, data) =>
    if data.id
      console.log("コメントの保存に成功")
      $('#msgbody').val('')
      # 送信するデータ(object_to_send)
      object_to_send =
        name: @send_user_name
        channel_name: @channel.name
      # websocketサーバーに送信
      @channel.trigger 'new_comment', object_to_send
      console.log("コメント送信")
    else
      console.log('文字数エラー')
      for i in data
        showAlert i, "alert-danger"
 
  receiveComment: (data) =>
    console.log "コメント受信 (送信者：#{data.name})"
    # アラート表示
    showAlert "#{data.name}さんからメッセージが送られました", "alert-info"
    # コメントをリロード
    $('#chat_area').load("/events/#{@event_id}/comments")

  sendEntry: (e, data) =>
    console.log "エントリーの保存に成功"
    # モーダルウィンドウ非表示の為の処理
    $('body').removeClass('modal-open')
    $(".modal-backdrop").remove()
    # ボタンをリロード
    $("#attendance_btn_#{data.id}").load("/entries/#{data.id}/btn")
    # 送信するデータ(object_to_send)
    object_to_send =
      name: @send_user_name
      channel_name: @channel.name
      timeplan_id: data.timeplan_id
    # websocketサーバーに送信
    @channel.trigger 'new_entry', object_to_send

  receiveEntry: (data) =>
    tpid = data.timeplan_id
    console.log "新しいエントリー(timeplan_id: #{tpid})"
    showAlert "参加者に変更がありました", "alert-info"
    $("#entries_list_tp_#{tpid}").load("/timeplans/#{tpid}/entries")

  disconnectWebsocket: =>
    @dispatcher.disconnect()
    console.log('WebSocket接続を終了しました')

# アラートを生成して表示
showAlert = (alert, type)->
  new_alert = $('<div>').addClass("alert alert-dismissible  top_alert #{type}")
  delete_button = $('<button>').addClass('close').attr({
    'type': 'button',
    'data-dismiss': "alert",
    'aria-label': "閉じる"
    }).append($('<span>').attr('aria-hidden','true').text('×'))
  new_alert.append(delete_button).append(alert)
  $('.add_alert').append(new_alert)
  new_alert.delay(2000).fadeOut(2000).queue ->
    new_alert.remove()

$ ->
  window.chatClass = new ChatClass("#{$('#chat').data('uri')}/websocket", true)
