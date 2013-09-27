json.array!(@writings) do |writing|
  json.extract! writing, :filename, :title, :revision, :revision_data
  json.url writing_url(writing, format: :json)
end
