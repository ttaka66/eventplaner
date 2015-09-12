json.array!(@events) do |event|
  json.extract! event, :id, :title, :message, :start, :end, :color, :orner, :allday, :category, :place, :address, :cost, :password
  json.url event_url(event, format: :json)
end
