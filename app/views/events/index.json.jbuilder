json.array!(@events) do |event|
  json.extract! event, :id, :title, :message, :start, :end, :color, :owner_id, :allday, :category, :place, :address, :cost, :password
  json.url event_url(event)
end
json.array!(@entries) do |entry|
	json.extract! entry.timeplan.event, :id, :title
	json.extract! entry.timeplan, :start, :end
	json.color '#FFD600'
	json.url event_url(entry.timeplan.event)
end
