json.array!(@direct_messages) do |direct_message|
  json.extract! direct_message, :id, :content
  json.url direct_message_url(direct_message, format: :json)
end
