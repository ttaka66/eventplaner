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
    alert("#{data.name}さんからメッセージを受信しました")
    $('#chat_area').load("/events/#{@event_id}/comments")


  disconnectWebsocket: =>
    @dispatcher.disconnect()
    console.log('WebSocket接続を終了しました')

$ ->
  window.chatClass = new ChatClass("localhost:3000/websocket", true)