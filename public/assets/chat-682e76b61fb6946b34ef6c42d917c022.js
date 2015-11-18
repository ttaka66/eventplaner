(function() {
  var showAlert,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.ChatClass = (function() {
    function ChatClass(url, useWebsocket) {
      this.disconnectWebsocket = bind(this.disconnectWebsocket, this);
      this.receiveNotification = bind(this.receiveNotification, this);
      this.sendNotification = bind(this.sendNotification, this);
      this.bindEvents = bind(this.bindEvents, this);
      this.dispatcher = new WebSocketRails(url, useWebsocket);
      this.event_id = $('#chat').data('event');
      this.send_user_name = $('#chat').data('username');
      this.channel = this.dispatcher.subscribe("" + this.event_id);
      console.log(url);
      console.log(this.channel);
      this.dispatcher.on_open = function(data) {
        return console.log('Websocketの接続ができました: ', data);
      };
      this.bindEvents();
    }

    ChatClass.prototype.bindEvents = function() {
      $('#chat').on('ajax:success', this.sendNotification);
      this.channel.bind('new_message', this.receiveNotification);
    };

    ChatClass.prototype.sendNotification = function(e, data) {
      var i, j, len, object_to_send, results;
      $('#msgbody').val('');
      console.log("ajaxSuccess");
      if (data.id) {
        object_to_send = {
          name: this.send_user_name,
          channel_name: this.channel.name
        };
        console.log(object_to_send);
        return this.channel.trigger('new_message', object_to_send);
      } else {
        console.log('文字数エラー');
        results = [];
        for (j = 0, len = data.length; j < len; j++) {
          i = data[j];
          results.push(showAlert(i, "alert-danger"));
        }
        return results;
      }
    };

    ChatClass.prototype.receiveNotification = function(data) {
      console.log('new comment received');
      showAlert(data.name + "さんからメッセージが送られました", "alert-info");
      return $('#chat_area').load("/events/" + this.event_id + "/comments");
    };

    ChatClass.prototype.disconnectWebsocket = function() {
      this.dispatcher.disconnect();
      return console.log('WebSocket接続を終了しました');
    };

    return ChatClass;

  })();

  showAlert = function(alert, type) {
    var delete_button, new_alert;
    new_alert = $('<div>').addClass("alert alert-dismissible " + type);
    delete_button = $('<button>').addClass('close').attr({
      'type': 'button',
      'data-dismiss': "alert",
      'aria-label': "閉じる"
    }).append($('<span>').attr('aria-hidden', 'true').text('×'));
    new_alert.append(delete_button).append(alert);
    return $('.add_alert').append(new_alert);
  };

  $(function() {
    console.log('起動確認');
    return window.chatClass = new ChatClass(($('#chat').data('uri')) + "/websocket", true);
  });

}).call(this);
