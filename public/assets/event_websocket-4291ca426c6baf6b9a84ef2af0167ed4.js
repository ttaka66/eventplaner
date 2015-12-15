(function() {
  var showAlert,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.ChatClass = (function() {
    function ChatClass(url, useWebsocket) {
      this.disconnectWebsocket = bind(this.disconnectWebsocket, this);
      this.receiveEntry = bind(this.receiveEntry, this);
      this.sendEntry = bind(this.sendEntry, this);
      this.receiveComment = bind(this.receiveComment, this);
      this.sendComment = bind(this.sendComment, this);
      this.bindEvents = bind(this.bindEvents, this);
      console.log("url(websocket): " + url);
      this.dispatcher = new WebSocketRails(url, useWebsocket);
      this.event_id = $('#chat').data('event');
      this.send_user_name = $('#chat').data('username');
      this.channel = this.dispatcher.subscribe("" + this.event_id);
      console.log(this.channel);
      this.dispatcher.on_open = function(data) {
        return console.log('Websocketの接続成功: ', data);
      };
      this.bindEvents();
    }

    ChatClass.prototype.bindEvents = function() {
      $('#chat').on('ajax:success', this.sendComment);
      $(document).on('ajax:success', '.entry_form', this.sendEntry);
      this.channel.bind('new_comment', this.receiveComment);
      return this.channel.bind('new_entry', this.receiveEntry);
    };

    ChatClass.prototype.sendComment = function(e, data) {
      var i, j, len, object_to_send, results;
      if (data.id) {
        console.log("コメントの保存に成功");
        $('#msgbody').val('');
        object_to_send = {
          name: this.send_user_name,
          channel_name: this.channel.name
        };
        this.channel.trigger('new_comment', object_to_send);
        return console.log("コメント送信");
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

    ChatClass.prototype.receiveComment = function(data) {
      console.log("コメント受信 (送信者：" + data.name + ")");
      showAlert(data.name + "さんからメッセージが送られました", "alert-info");
      return $('#chat_area').load("/events/" + this.event_id + "/comments");
    };

    ChatClass.prototype.sendEntry = function(e, data) {
      var object_to_send;
      console.log("エントリーの保存に成功");
      $('body').removeClass('modal-open');
      $(".modal-backdrop").remove();
      $("#attendance_btn_" + data.id).load("/entries/" + data.id + "/btn");
      object_to_send = {
        name: this.send_user_name,
        channel_name: this.channel.name,
        timeplan_id: data.timeplan_id
      };
      return this.channel.trigger('new_entry', object_to_send);
    };

    ChatClass.prototype.receiveEntry = function(data) {
      var tpid;
      tpid = data.timeplan_id;
      console.log("新しいエントリー(timeplan_id: " + tpid + ")");
      showAlert("参加者に変更がありました", "alert-info");
      return $("#entries_list_tp_" + tpid).load("/timeplans/" + tpid + "/entries");
    };

    ChatClass.prototype.disconnectWebsocket = function() {
      this.dispatcher.disconnect();
      return console.log('WebSocket接続を終了しました');
    };

    return ChatClass;

  })();

  showAlert = function(alert, type) {
    var delete_button, new_alert;
    new_alert = $('<div>').addClass("alert alert-dismissible  top_alert " + type);
    delete_button = $('<button>').addClass('close').attr({
      'type': 'button',
      'data-dismiss': "alert",
      'aria-label': "閉じる"
    }).append($('<span>').attr('aria-hidden', 'true').text('×'));
    new_alert.append(delete_button).append(alert);
    $('.add_alert').append(new_alert);
    return new_alert.delay(2000).fadeOut(2000).queue(function() {
      return new_alert.remove();
    });
  };

  $(function() {
    return window.chatClass = new ChatClass(($('#chat').data('uri')) + "/websocket", true);
  });

}).call(this);
