json.array!(@subjects) do |subject|
  json.extract! subject, :id, :title, :body
  json.url subject_url(subject, format: :json)
end
