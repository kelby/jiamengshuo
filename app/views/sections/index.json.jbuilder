json.array!(@sections) do |section|
  json.extract! section, :id, :heading, :body, :position, :post_id
  json.url section_url(section, format: :json)
end
