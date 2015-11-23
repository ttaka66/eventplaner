# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

init = ->

  # select = (start, end, allDay) ->
  #   title = window.prompt("title")
  #   data = {
  #     event: 
  #       title: title
  #       start: start
  #       end: end
  #       allDay: allDay
  #   }

  #   $.ajax({
  #     type: "POST",
  #     url: "/events",
  #     data: data,
  #     success: ->
  #       calendar.fullCalendar('refetchEvents');
  #       return
  #   })

  #   calendar.fullCalendar('unselect')

  #   return

  calendar = $('#calendar').fullCalendar(
    defaultView: 'agendaWeek'
    header:
      left: 'prev,next today',
      center: 'title'
      right: 'agendaDay agendaWeek month'
    events: '/events.json'
    selectable: true
    selectHelper: true
    ignoreTimezone: false
    # select: select
    timeFormat: 'H:mm'
    titleFormat:
      month: 'YYYY M月'
      week: "YYYY年M月D日"
      day: "YYYY年M月D日[(]ddd[)]"
    columnFormat:
      week: "M/D[(]ddd[)]"
    monthNames: [
      '１月'
      '２月'
      '３月'
      '４月'
      '５月'
      '６月'
      '７月'
      '８月'
      '９月'
      '１０月'
      '１１月'
      '１２月'
    ]
    dayNamesShort: [
      '日'
      '月'
      '火'
      '水'
      '木'
      '金'
      '土'
    ]
    buttonText:
      today: '今日'
      month: '月'
      week: '週'
      day: '日'
    axisFormat: 'H:mm'
  )

  return

# ページロード時にinit関数を実行
$(document).ready(init)
$(document).on('page:change', init)