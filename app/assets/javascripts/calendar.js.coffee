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
      right: 'agendaDay agendaWeek month today prev next'
    events: '/events.json'
    selectable: true
    selectHelper: true
    ignoreTimezone: false
    # select: select
    buttonText:
      today: 'Hoy'
      month: 'month'
      week: 'week'
      day: 'day'
  )

  return

# ページロード時にinit関数を実行
$(document).ready(init)
$(document).on('page:change', init)