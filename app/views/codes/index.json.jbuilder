json.array!(@codes) do |code|
  json.extract! code, :filename, :title, :revision, :revision_data, :language
  json.url code_url(code, format: :json)
end
