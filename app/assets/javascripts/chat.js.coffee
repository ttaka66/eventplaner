class @ChatClass
  constructor: (url, useWebsocket) ->
    # これがソケットのディスパッチャー
    @dispatcher = new WebSocketRails(url, useWebsocket)
    @event_id = $('#chat').data('event')
    @send_user_name = $('#chat').data('username')
    @channel = @dispatcher.subscribe("#{@event_id}")

    console.log(url)
    console.log(@channel)

    @dispatcher.on_open = (data) ->
    	console.log('Websocketの接続ができました: ', data)

    # イベントを監視
    @bindEvents()
 
  bindEvents: () =>
    # commentの保存が成功したら@sendNotificationメソッドを実行
    $('#chat').on 'ajax:success', @sendNotification
    # サーバーからnew_messageイベントを受け取ったらreceiveNotificationメソッドを実行
    @channel.bind 'new_message', @receiveNotification
    return
 
  sendNotification: (e, data) =>
    $('#msgbody').val('')
    console.log("ajaxSuccess")
    if data.id
      object_to_send=
        name: @send_user_name
        channel_name: @channel.name
      console.log(object_to_send)
      @channel.trigger 'new_message', object_to_send
    else
      console.log('文字数エラー')
      for i in data
        showAlert i, "alert-danger"
 
  receiveNotification: (data) =>
    console.log 'new comment received'
    showAlert "#{data.name}さんからメッセージが送られました", "alert-info"
    $('#chat_area').load("/events/#{@event_id}/comments")


  disconnectWebsocket: =>
    @dispatcher.disconnect()
    console.log('WebSocket接続を終了しました')

# アラートを生成して表示
showAlert = (alert, type)->
  new_alert = $('<div>').addClass("alert alert-dismissible #{type}")
  delete_button = $('<button>').addClass('close').attr({
    'type': 'button',
    'data-dismiss': "alert",
    'aria-label': "閉じる"
    }).append($('<span>').attr('aria-hidden','true').text('×'))
  new_alert.append(delete_button).append(alert)
  $('.add_alert').append(new_alert)

$ ->
  console.log('起動確認')
  window.chatClass = new ChatClass("#{$('#chat').data('uri')}/websocket", true)