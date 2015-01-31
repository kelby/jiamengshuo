json.array!(@wishes) do |wish|
  json.extract! wish, :id, :content
  json.url wish_url(wish, format: :json)
end
