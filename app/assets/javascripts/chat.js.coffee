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
 
  sendNotification: (event) =>
    $('#msgbody').val('')
    console.log("ajaxSuccess")
    object_to_send=
      name: @send_user_name
      channel_name: @channel.name
    console.log(object_to_send)

    @channel.trigger 'new_message', object_to_send
 
  receiveNotification: (data) =>
    console.log 'new comment received'
    # $('.alert').fadeIn(1000).delay(2000).fadeOut(2000)
    new_alert = $('<div>').addClass('alert alert-info alert-dismissible')
    delete_button = $('<button>').addClass('close').attr({
        'type': 'button',
        'data-dismiss': "alert",
        'aria-label': "閉じる"
      }).append($('<span>').attr('aria-hidden','true').text('×'))
    new_alert.append(delete_button).append("#{data.name}さんからメッセージが送られました")
    $('.add_alert').append(new_alert)
    $('#chat_area').load("/events/#{@event_id}/comments")


  disconnectWebsocket: =>
    @dispatcher.disconnect()
    console.log('WebSocket接続を終了しました')

$ ->
  console.log('起動確認')
  window.chatClass = new ChatClass("#{$('#chat').data('uri')}/websocket", true)