class @ChatClass
  constructor: (url, useWebsocket) ->
    # これがソケットのディスパッチャー
    @dispatcher = new WebSocketRails(url, useWebsocket)
    @event_id = $('#chat').data('event')
    @username = $('#chat').data('username')
    @channel = @dispatcher.subscribe("#{@event_id}")

    console.log(url)
    console.log(@channel)

    @dispatcher.on_open = (data) ->
    	console.log('Websocketの接続ができました: ', data)

    # イベントを監視
    @bindEvents()
 
  bindEvents: () =>
    # 送信ボタンが押されたらサーバへメッセージを送信
    $('#send').on 'click', @sendMessage
    # サーバーからnew_messageを受け取ったらreceiveMessageを実行
    @channel.bind 'new_message', @receiveMessage
    return
 
  sendMessage: (event) =>
    # サーバ側にsend_messageのイベントを送信
    # オブジェクトでデータを指定
    msg_body = $('#msgbody').val()
    object_to_send=
    	name: @username
    	body: msg_body
    	channel_name: @channel.name
    console.log(object_to_send)

    @channel.trigger 'new_message', object_to_send
 
  receiveMessage: (data) =>
    console.log 'channel event received: ' + data
    # 受け取ったデータをprepend
    h4 = $('<h4>').addClass('media-heading').text(data.name)

    div = $('<div>').addClass('media-body')
    a = $('<a>').addClass('pull-left')
    img =$('<img>').attr('src', '/assets/Argentina.png').attr('alt', 'Argentina')
    .attr('width', 64).attr('height', 64)
    li = $('<li>').addClass('media list-group-item pink')


    
    div = div.html("<p>#{data.body}</p><p style='text-align:right;'>#{}</p>").prepend(h4)
    a = a.prepend(img)
    li = li.append(a).append(div)
    console.log(li)

    $('#chat_view').prepend(li)

  disconnectWebsocket: =>
    @dispatcher.disconnect()
    console.log('WebSocket接続を終了しました')

$ ->
# $(document).on 'page:change', ->

# initChat = ->

  window.chatClass = new ChatClass("localhost:3000/websocket", true)
  $(window).on 'page:before-change', ->
    console.log('ページが変わりました')
    window.chatClass.disconnectWebsocket()
    $(window).unbind 'page:before-change'
    $(window).unbind 'ready'
    $(window).unbind 'page:load'

# $(document).ready(initChat)
# $(document).on('page:change', initChat)
